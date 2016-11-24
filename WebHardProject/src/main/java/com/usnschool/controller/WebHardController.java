package com.usnschool.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.usnschool.Util.FileUploadUtil;
import com.usnschool.domain.BoardFileVO;
import com.usnschool.domain.BoardImgVO;
import com.usnschool.domain.BoardVO;
import com.usnschool.domain.CommunityReplyVO;
import com.usnschool.domain.CommunityVO;
import com.usnschool.domain.Criteria;
import com.usnschool.domain.PageMaker;
import com.usnschool.domain.UserDownloadVO;
import com.usnschool.domain.UserVO;
import com.usnschool.service.WebHardService;

@Controller
@RequestMapping(value = "/board")
public class WebHardController {
	@Inject
	private WebHardService service;

	@Resource(name = "upLoadPath")
	private String upLoadPath;

	@RequestMapping(value = "member_j", method = RequestMethod.GET)
	public void memberj() throws Exception {

	}
	
	@RequestMapping(value = "member_m", method = RequestMethod.GET)
	public void memberm(String id, Model model) throws Exception {
		UserVO uservo = service.getBoardVOById(id);
		model.addAttribute("uservo", uservo);
	}

	@RequestMapping(value = "filewrite", method = RequestMethod.GET)
	public void filewrite(BoardFileVO BoardF, Model model) throws Exception {

	}

	@ResponseBody
	@RequestMapping(value = "register", method = RequestMethod.POST)
	public ResponseEntity<String> register(UserVO uservo) throws Exception {
		service.register(uservo);

		ResponseEntity<String> entity = null;
		try {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "idoverlapcheck", method = RequestMethod.GET)
	public ResponseEntity<String> idoverlapcheck(String id) throws Exception {
		String idexist = service.idoverlapcheck(id);

		ResponseEntity<String> entity = null;
		try {
			entity = new ResponseEntity<String>(idexist, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(String id, String pw, HttpSession httpsession, String remember, HttpServletResponse response)
			throws Exception {
		System.out.println("ㅈㅈ");
		UserVO uservo = service.login(id, pw);
		if (uservo != null && !uservo.getGrade().equals("deleted")) {

			httpsession.setAttribute("login", uservo.getId());
			httpsession.setAttribute("grade", uservo.getGrade());
			httpsession.setAttribute("point", String.valueOf(uservo.getPoint()));
			if (remember != null) {
				Cookie cookie = new Cookie("logincookie", uservo.getId());
				cookie.setMaxAge(60 * 60 * 24 * 7);
				Cookie gradecookie = new Cookie("gradecookie", uservo.getGrade());
				gradecookie.setMaxAge(60 * 60 * 24 * 7);
				Cookie pointcookie = new Cookie("pointcookie", String.valueOf(uservo.getPoint()));
				pointcookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(cookie);
				response.addCookie(gradecookie);
				response.addCookie(pointcookie);
			}
		}
		return "redirect:../board/mainpage";
	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public void logout(HttpServletRequest request, HttpSession httpsession, HttpServletResponse response)
			throws Exception {
		httpsession.invalidate();

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookies[i].setMaxAge(0);
				response.addCookie(cookies[i]);
			}
		}

		String referer = request.getHeader("Referer");
		response.sendRedirect(referer);
	}

	@RequestMapping(value = "mainpage", method = RequestMethod.GET)
	public void mainpage(@ModelAttribute("cri") Criteria cri, Model model, String genre, String searchword, String field) throws Exception {
		PageMaker pageMaker = new PageMaker();
		cri.setGenre(genre);
		cri.setSearchword(searchword);
		cri.setField(field);
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCountCriteria(cri));
		model.addAttribute("List", service.listCriteria(cri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("genre", genre);
	}

	@RequestMapping(value = "listCri", method = RequestMethod.GET)
	public void listAll(Criteria cri, Model model) throws Exception {
		model.addAttribute("List", service.listCriteria(cri));

	}

	@ResponseBody
	@RequestMapping(value = "registerboard", method = RequestMethod.POST)
	public ResponseEntity<String> registerboard(BoardVO boardvo) throws Exception {

		service.insertboard(boardvo);

		ResponseEntity<String> entity = null;
		try {
			entity = new ResponseEntity<String>(service.getLastBno(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}

	@ResponseBody
	@RequestMapping(value = "fileupload", method = RequestMethod.POST)
	public ResponseEntity<String> droptest(MultipartFile file, String count, String bno) throws Exception {
		UUID uuid = UUID.randomUUID();
		String calcUpLoadPath = FileUploadUtil.calcPath(upLoadPath);

		String filename = file.getOriginalFilename();
		String checkname = filename.substring(filename.indexOf(".") + 1);

		if (checkname.equals("png") || checkname.equals("gif") || checkname.equals("jpg")) {
			BoardImgVO boardimgvo = new BoardImgVO();
			boardimgvo.setBno(Integer.parseInt(bno));
			boardimgvo.setFilename(filename);
			boardimgvo.setPath(calcUpLoadPath + "/" + uuid.toString() + file.getOriginalFilename());
			service.imgUpLoad(boardimgvo);
		} else {
			BoardFileVO vo = new BoardFileVO();
			vo.setCapacity(file.getSize());
			vo.setFilename(filename);
			vo.setBno(Integer.parseInt(bno));
			vo.setPath(calcUpLoadPath + "/" + uuid.toString() + file.getOriginalFilename());
			int point = (int)(file.getSize()/10000000);
			if(point < 10){
				point = 10;
			}
			vo.setPoint(point);
			service.fileUpLoad(vo);
		}

		InputStream is = file.getInputStream();
		FileUploadUtil.makeFile(calcUpLoadPath, uuid.toString() + file.getOriginalFilename(), is);

		ResponseEntity<String> entity = null;
		try {
			entity = new ResponseEntity<String>(count, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}

	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public void detail(HttpSession httpsession, Integer bno, Model model) throws Exception {
		String loginid = (String) httpsession.getAttribute("login");
		model.addAttribute("boardvo", service.getBoardvo(bno));
		model.addAttribute("boardvofilelist", service.getboardfilevo(bno));
		model.addAttribute("boardvoimglist", service.getboardimgvo(bno));
		List<UserDownloadVO> userdownvo = service.getuserdownload(loginid, bno);
		if(userdownvo.size() != 0){
			model.addAttribute("userdownloadlist", userdownvo);
		}else{
			model.addAttribute("userdownloadlist", null);
		}
		
		
			
	}

	@ResponseBody
	@RequestMapping(value = "showimg", method = RequestMethod.GET)
	public ResponseEntity<byte[]> showimg(String path) throws Exception {
		FileInputStream fis = new FileInputStream(path);
		BufferedInputStream bis = new BufferedInputStream(fis);
		byte[] imgbytes = new byte[fis.available()];
		int count = 0;

		while (bis.available() > 0) {
			imgbytes[count] = (byte) bis.read();
			count++;
		}

		HttpHeaders headers = new HttpHeaders();
		String fileextension = path.substring(path.indexOf("."));
		if (fileextension.equals("png")) {
			headers.setContentType(MediaType.IMAGE_PNG);
		} else if (fileextension.equals("jpg")) {
			headers.setContentType(MediaType.IMAGE_JPEG);
		} else if (fileextension.equals("gif")) {
			headers.setContentType(MediaType.IMAGE_GIF);
		}

		bis.close();

		ResponseEntity<byte[]> entity = null;
		try {
			entity = new ResponseEntity<byte[]>(imgbytes, headers, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}

	@RequestMapping(value = "download/{bfno},{filename},{writer},{bno},{point}", method = RequestMethod.GET)
	public void file(HttpSession httpsession, HttpServletResponse response, Model model, 
			@PathVariable("bfno") int bfno, @PathVariable("filename") String filename, 
			@PathVariable("writer") String writer, @PathVariable("bno") int bno, 
			@PathVariable("point") int point) throws Exception {
	
		String loginid = (String)httpsession.getAttribute("login");
		String sessionpoint = (String)httpsession.getAttribute("point");
		if(!loginid.equals(writer)){
			service.calpoint(loginid, writer, bfno, bno, point, filename);
			httpsession.removeAttribute("point");
			httpsession.setAttribute("point", String.valueOf((Integer.parseInt(sessionpoint)-point)));
		}
		
		String path = service.getfilepath(bfno);
		
		File file = new File(path);
		
		String extention = file.getName().substring(file.getName().lastIndexOf("."));
		
		response.setHeader("Content-Disposition", "attachment; filename="+ java.net.URLEncoder.encode(filename+extention, "UTF-8") + ";");

		response.setContentLength((int) file.length());

		InputStream inputStream = new BufferedInputStream(new FileInputStream(file));

		FileCopyUtils.copy(inputStream, response.getOutputStream());

	}
	
	@RequestMapping(value="mydownload/{bfno},{filename}", method =RequestMethod.GET)
	public void filedownload(@PathVariable("bfno") int bfno,@PathVariable("filename") String filename ,HttpServletResponse response) throws Exception{
		String path = service.getfilepath(bfno);
		File file = new File(path);
		String extention = file.getName().substring(file.getName().lastIndexOf("."));
		response.setHeader("Content-Disposition", "attachment; filename="+ java.net.URLEncoder.encode(filename+extention, "UTF-8") + ";");
		response.setContentLength((int) file.length());
		InputStream inputStream = new BufferedInputStream(new FileInputStream(file));
		FileCopyUtils.copy(inputStream, response.getOutputStream());
	}
	
	@ResponseBody
	@RequestMapping(value="modifymember", method = RequestMethod.POST)
	public ResponseEntity<String> modifymember(@RequestBody UserVO uservo) throws Exception{

		service.changeUserInfo(uservo);
		ResponseEntity<String> entity = null;
		try {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/deleteid", method = RequestMethod.POST)
	public ResponseEntity<String> deleteid(String id, String password, HttpSession httpsession, HttpServletRequest request, HttpServletResponse response) throws Exception{
		UserVO uservo = service.checkid(id, password);
		ResponseEntity<String> entity = null;
		try {
			if(uservo != null){
				service.changegrade(id);
				httpsession.invalidate();

				Cookie[] cookies = request.getCookies();
				if (cookies != null) {
					for (int i = 0; i < cookies.length; i++) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
					}
				}
			}
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}
	
	@RequestMapping(value="mydownpage", method=RequestMethod.GET)
	public void mydownload(String id, Model model) throws Exception{
		List<UserDownloadVO> userdownlist = service.getUserDownList(id);
		
		model.addAttribute("userdownlist", userdownlist);
	}
	
	@ResponseBody
	@RequestMapping(value="deleteboard", method =RequestMethod.POST)
	public ResponseEntity<String> deleteboard(String bno) throws Exception{
	
		List<BoardFileVO> filelist = service.getboardfilevo(Integer.parseInt(bno));
		List<BoardImgVO> imglist = service.getboardimgvo(Integer.parseInt(bno));
		for (int i = 0; i < filelist.size(); i++) {
			File file = new File(filelist.get(i).getPath());
			if(file.exists()){
				file.delete();
			}
		}
		for (int i = 0; i < imglist.size(); i++) {
			File file = new File(imglist.get(i).getPath());
			if(file.exists()){
				file.delete();
			}
		}
		service.deleteBoard(bno);
		ResponseEntity<String> entity = null;
		try {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}
	
	////////////////////////////////////////////////////////////추가
	
	
	@RequestMapping(value="community", method=RequestMethod.GET)
	public void community(Model model, @ModelAttribute("cri") Criteria cri, String field, String keyword) throws Exception{
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.clistCountCriteria(cri));
		cri.setField(field);
		cri.setSearchword(keyword);
		model.addAttribute("CList",service.communitylistcri(cri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	@RequestMapping(value="cwrite", method=RequestMethod.GET)
	public void cwriteGET(CommunityVO cboard,Model model) throws Exception{
		
	}
	@RequestMapping(value="cwrite" , method=RequestMethod.POST)
	public String cwritePOST(CommunityVO cboard, Model model) throws Exception{
		service.regist(cboard);
		model.addAttribute("result", "success");
		
		return "redirect:../board/community";
	}

	
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public void modifyGET(int cbno,Model model) throws Exception{
		model.addAttribute(service.read(cbno));
	}
	@RequestMapping(value="modify", method=RequestMethod.POST)
	public String modifyPOST(CommunityVO cboard,RedirectAttributes rttr) throws Exception{
		service.modify(cboard);

		return "redirect:../board/community";
	}
	@RequestMapping(value="remove", method=RequestMethod.POST)
		public String remove(@RequestParam("cbno") int cbno, RedirectAttributes rttr)throws Exception{
		service.remove(cbno);
		
		rttr.addFlashAttribute("msg","Success");
		
		return "redirect:../board/community";
		 
	} 

	
	@RequestMapping(value="read", method=RequestMethod.GET)
	public void read(@RequestParam("cbno")int cbno,Model model, Criteria cri) throws Exception{
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.rlistCountCriteria(cri));
		cri.setCbno(cbno);
		if(cri.getPage() != 1){
			service.increaseCount(cbno);
		}
		model.addAttribute("replylist", service.readReply(cri));
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute(service.read(cbno));
	}

	@RequestMapping(value="registerreply",method = RequestMethod.POST)
	public String registerreply(CommunityReplyVO creplyvo) throws Exception{
			service.registerReply(creplyvo);
		return "redirect:../board/read?cbno="+creplyvo.getCbno();
	}
	
	
	
}
