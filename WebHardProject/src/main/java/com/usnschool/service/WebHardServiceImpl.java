package com.usnschool.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.usnschool.domain.BoardFileVO;
import com.usnschool.domain.BoardImgVO;
import com.usnschool.domain.BoardVO;
import com.usnschool.domain.CommunityReplyVO;
import com.usnschool.domain.CommunityVO;
import com.usnschool.domain.Criteria;
import com.usnschool.domain.UserDownloadVO;
import com.usnschool.domain.UserVO;
import com.usnschool.persistence.WebHardDAO;

@Service
public class WebHardServiceImpl implements WebHardService {
	@Inject
	private WebHardDAO dao;
	
	@Override
	public void fileUpLoad(BoardFileVO vo) throws Exception {
		dao.fileUpLoad(vo);
	}
	
	@Override
	public UserVO login(String id, String password) throws Exception {
		return dao.login(id, password);
	}
	
	@Override
	public void insertboard(BoardVO boardvo) throws Exception {
		dao.insertboard(boardvo);
	}
	
	@Override
	public String getLastBno() throws Exception {
		return dao.getLastBno();
	}
	
	@Override
	public void imgUpLoad(BoardImgVO boardimgvo) throws Exception {
		dao.imgUpLoad(boardimgvo);
	}
	
	@Override
	public String idoverlapcheck(String id) throws Exception {
		return dao.idoverlapcheck(id);
	}	
	
	@Override
	public void register(UserVO uservo) throws Exception {
		dao.register(uservo);
		
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return dao.listAll();
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		return dao.listCriteria(cri);
		
	}

	@Override
	public int listCountCriteria(Criteria cri) throws Exception {
		return dao.countPaging(cri);
	}
	
	@Override
	public List<BoardFileVO> getboardfilevo(Integer bno) throws Exception {
		return dao.getBoardfilevo(bno);
	}
	
	@Override
	public List<BoardImgVO> getboardimgvo(Integer bno) throws Exception {
		return dao.getBoardimgvo(bno);
	}
	@Override
	public BoardVO getBoardvo(Integer bno) throws Exception {
		return dao.getBoardvo(bno);
	}

	@Override
	public String getfilepath(Integer bfno) throws Exception {
		return dao.getFilePath(bfno);
	}
	
	@Transactional
	@Override
	public void calpoint(String loginid, String writer, int bfno, int bno, int point, String filename) throws Exception {
		dao.decreasepoint(loginid, point);
		dao.increasepoint(writer, point);
		dao.registerdowninfo(bfno, loginid, bno, filename);
	}
	
	@Override
	public List<UserDownloadVO> getuserdownload(String loginid, int bno) throws Exception {
		return dao.getuserdownload(loginid, bno);
	}
	
	@Override
	public UserVO getBoardVOById(String id) throws Exception {
		return dao.getBoardVOById(id);
	}
	@Override
	public void changeUserInfo(UserVO uservo) throws Exception {
		dao.changeUserInfo(uservo);
	}
	
	@Override
	public UserVO checkid(String id, String password) throws Exception {
		return dao.checkid(id, password);
	}
	
	@Override
	public void deleteid(String id) throws Exception {
		dao.deleteid(id);
	}
	@Override
	public void changegrade(String id) throws Exception {
		dao.changegrade(id);
	}
	@Override
	public List<UserDownloadVO> getUserDownList(String id) throws Exception {
		return dao.getUserDownList(id);
	}
	
	
	@Transactional
	@Override
	public void deleteBoard(String bno) throws Exception {
		dao.deleteFile(bno);
		dao.deleteImg(bno);
		dao.deleteBoard(bno);
	}
	/////////////////////////////////////////////////////////////////////////////////////////////
	@Override
	public List<CommunityVO> CommunityAll() throws Exception{
		return dao.CommunityAll();
	}

	@Override
	public void regist(CommunityVO cboard) throws Exception {
		dao.insertcboard(cboard);
	
	} 
	@Override
	public CommunityVO read(Integer cbno) throws Exception {
		return dao.read(cbno);
	}
	@Override
	public void modify(CommunityVO cboard) throws Exception {
		dao.update(cboard);
	}
	@Override
	public void remove(Integer cbno) throws Exception {
		dao.delete(cbno);
	}


	@Override
	public void removeReply(Integer cbrno) throws Exception {
		dao.rplyDelete(cbrno);
		
	}
	@Override
	public void increaseCount(Integer cbno) throws Exception {
		dao.increaseCount(cbno);
	}
	@Override
	public int clistCountCriteria(Criteria cri) throws Exception {
		return dao.clistCountCriteria(cri);
	}
	
	@Override
	public List<CommunityVO> communitylistcri(Criteria cri) throws Exception {
		return dao.communitylistcri(cri);
	}
	
	@Override
	public void registerReply(CommunityReplyVO creplyvo) throws Exception {
		dao.registerReply(creplyvo);
	}

	@Override
	public int rlistCountCriteria(Criteria cri) throws Exception {
		return dao.rlistCountCriteria(cri);
	}
	
	@Override
	public List<CommunityReplyVO> readReply(Criteria cri) throws Exception {
		return dao.readReply(cri);
	}
}
