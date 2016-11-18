package com.usnschool.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.usnschool.domain.BoardFileVO;
import com.usnschool.domain.BoardImgVO;
import com.usnschool.domain.BoardVO;
import com.usnschool.domain.CommunityReplyVO;
import com.usnschool.domain.CommunityVO;
import com.usnschool.domain.Criteria;
import com.usnschool.domain.UserDownloadVO;
import com.usnschool.domain.UserVO;


@Repository
public class WebHardDAOImpl implements WebHardDAO {
	
	@Inject
	private SqlSession session;
	
	private String namespace= "com.usnschool.mapper.WebHardMapper";
	
	@Override
	public void fileUpLoad(BoardFileVO vo) throws Exception {
			session.insert(namespace+".fileUpLoad", vo);
	}
	
	@Override
	public UserVO login(String id, String password) throws Exception {
		HashMap<String, String> idmap = new HashMap<>();
		idmap.put("id", id);
		idmap.put("password", password);
		return session.selectOne(namespace+".login", idmap);
	}
	
	@Override
	public void insertboard(BoardVO boardvo) throws Exception {
		session.insert(namespace+".insertboard", boardvo);
	}
	
	@Override
	public String getLastBno() throws Exception {
		return session.selectOne(namespace+".getlastbno");
	}
	
	@Override
	public void imgUpLoad(BoardImgVO boardimgvo) throws Exception {
		session.insert(namespace+".imgupload", boardimgvo);
	}
	
	@Override
	public String idoverlapcheck(String id) throws Exception {
		return session.selectOne(namespace+ ".idoverlapcheck", id);
	}
	
	@Override
	public void register(UserVO uservo) throws Exception {
		session.insert(namespace+".register", uservo);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
		return session.selectList(namespace+".listAll");
				
	}

	@Override
	public List<BoardVO> listPage(int page) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".listCriteria");
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		// TODO Auto-generated method stub
		return session.selectList(namespace+".listCriteria",cri);
	}

	@Override
	public int countPaging(Criteria cri) throws Exception {

		return session.selectOne(namespace+".countPaging", cri);
	}
	
	@Override
	public List<BoardFileVO> getBoardfilevo(Integer bno) throws Exception {
		return session.selectList(namespace+".getboardfilevo", bno);
	}
	@Override
	public List<BoardImgVO> getBoardimgvo(Integer bno) throws Exception {
		return session.selectList(namespace+".getboardimgvo", bno);
	}
	@Override
	public BoardVO getBoardvo(Integer bno) throws Exception {
		return session.selectOne(namespace+".getboardvo", bno);
	}

	@Override
	public String getFilePath(Integer bfno) throws Exception {
		return session.selectOne(namespace+".getfilepath",bfno);
	}
	
	@Override
	public void decreasepoint(String loginid, int point) {
		HashMap<String, String> hashmap = new HashMap<>();
		hashmap.put("loginid", loginid);
		hashmap.put("point", String.valueOf(point));
		session.update(namespace+".decreasepoint", hashmap);
	}
	
	@Override
	public void increasepoint(String writer, int point) {
		HashMap<String, String> hashmap = new HashMap<>();
		hashmap.put("writer", writer);
		hashmap.put("point", String.valueOf(point));
		session.update(namespace+".increasepoint", hashmap);
	}
	
	@Override
	public void registerdowninfo(int bfno, String loginid, int bno, String filename) {
		HashMap<String, String> hashmap = new HashMap<>();
		hashmap.put("bfno", String.valueOf(bfno));
		hashmap.put("loginid", loginid);
		hashmap.put("bno", String.valueOf(bno));
		hashmap.put("filename", filename);
		session.insert(namespace+".registerdowninfo", hashmap);
	}
	
	@Override
	public List<UserDownloadVO> getuserdownload(String loginid, int bno) throws Exception {
		HashMap<String, String> hashmap = new HashMap<>();
		hashmap.put("bno", String.valueOf(bno));
		hashmap.put("loginid", loginid);
		return session.selectList(namespace+".getuserdownload", hashmap);
	}
	
	@Override
	public UserVO getBoardVOById(String id) throws Exception {
		return session.selectOne(namespace+".getboardvobyid", id);
	}
	
	@Override
	public void changeUserInfo(UserVO uservo) throws Exception {
		session.update(namespace+".changeuserinfo", uservo);
	}
	
	@Override
	public UserVO checkid(String id, String password) throws Exception {
		HashMap<String, String> hashmap = new HashMap<>();
		hashmap.put("id", id);
		hashmap.put("password", password);
		return session.selectOne(namespace+".checkid", hashmap);
	}
	
	@Override
	public void deleteid(String id) throws Exception {
		session.delete(namespace+".deleteid", id);
	}
	
	@Override
	public void changegrade(String id) throws Exception {
		session.update(namespace+".changegrade",id);
		
	}
	
	@Override
	public List<UserDownloadVO> getUserDownList(String id) throws Exception {
		return session.selectList(namespace+".getuserdownlist", id);
	}
	@Override
	public void deleteBoard(String bno) throws Exception {
		session.delete(namespace+".deleteboard", bno);
	}

	@Override
	public void deleteFile(String bno) throws Exception {
		session.delete(namespace+".deletefile", bno);
	}
	
	@Override
	public void deleteImg(String bno) throws Exception {
		session.delete(namespace+".deleteimg", bno);
	}
	
////////////////////////////////////////////////////////////////////////////

	
	@Override
	public List<CommunityVO> CommunityAll() throws Exception {
	return session.selectList(namespace+".communityAll");	
	}
	
	
	
	@Override
	public void insertcboard(CommunityVO cvo) throws Exception {
	session.insert(namespace+".insertcboard", cvo);
	}
	
	@Override
	public CommunityVO read(Integer cbno) throws Exception {
	return session.selectOne(namespace+".read",cbno);
	}
	
	@Override
	public void update(CommunityVO cvo) throws Exception {
	session.update(namespace+".update",cvo);
	
	}
	
	@Override
	public void delete(Integer cbno) throws Exception {
	session.delete(namespace+".delete",cbno);
	
	}
	
	
	
	
	@Override
	public void rplyDelete(Integer brno) throws Exception {
	session.delete(namespace+".rplyDelete",brno);
	
	}

	
	@Override
	public void increaseCount(Integer cbno) throws Exception {
		session.update(namespace+".increasecount", cbno);
	}

	@Override
	public int clistCountCriteria(Criteria cri) throws Exception {
		return session.selectOne(namespace+".clistcountcriteria", cri);
	}
	
	@Override
	public List<CommunityVO> communitylistcri(Criteria cri) throws Exception {
		return session.selectList(namespace+".communitylistcri", cri);
	}
	
	@Override
	public void registerReply(CommunityReplyVO creplyvo) throws Exception {
		session.insert(namespace+".registerreply", creplyvo);
	}
	
	@Override
	public int rlistCountCriteria(Criteria cri) throws Exception {
		return session.selectOne(namespace+".rlistcountcriteria", cri);
	}
	
	@Override
	public List<CommunityReplyVO> readReply(Criteria cri) throws Exception {
		return session.selectList(namespace+".readReply", cri);
	}
	
}
