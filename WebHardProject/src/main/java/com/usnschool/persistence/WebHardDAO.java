package com.usnschool.persistence;

import java.util.List;

import com.usnschool.domain.BoardFileVO;
import com.usnschool.domain.BoardImgVO;
import com.usnschool.domain.BoardVO;
import com.usnschool.domain.CommunityReplyVO;
import com.usnschool.domain.CommunityVO;
import com.usnschool.domain.Criteria;
import com.usnschool.domain.UserDownloadVO;
import com.usnschool.domain.UserVO;

public interface WebHardDAO {
	public void fileUpLoad(BoardFileVO vo) throws Exception;
	
	public UserVO login(String id, String password) throws Exception;
	
	public void insertboard(BoardVO boardvo) throws Exception;
	
	public String getLastBno() throws Exception;
	
	public void imgUpLoad(BoardImgVO boardimgvo) throws Exception;
	
	public String idoverlapcheck(String id) throws Exception;
	
	public void register(UserVO uservo) throws Exception;
	
	public List<BoardVO> listAll() throws Exception;

	public List<BoardVO> listPage(int page) throws Exception;
	
	public List<BoardVO> listCriteria(Criteria cri) throws Exception;
	
	public int countPaging(Criteria cri) throws Exception;
	
	public BoardVO getBoardvo(Integer bno) throws Exception;
	
	public List<BoardFileVO> getBoardfilevo(Integer bno) throws Exception;
	
	public List<BoardImgVO> getBoardimgvo(Integer bno) throws Exception;
	
	public String getFilePath(Integer bfno) throws Exception;

	public void decreasepoint(String loginid, int point);

	public void increasepoint(String writer, int point);

	public void registerdowninfo(int bfno, String loginid, int bno, String filename);
	
	public List<UserDownloadVO> getuserdownload(String loginid, int bno) throws Exception;
	
	public UserVO getBoardVOById(String id) throws Exception;
	
	public void changeUserInfo(UserVO uservo) throws Exception;
	
	public UserVO checkid(String id, String password) throws Exception;
	
	public void deleteid(String id) throws Exception;
	
	public void changegrade(String id) throws Exception;
	
	public List<UserDownloadVO> getUserDownList(String id) throws Exception;
	
	public void deleteFile(String bno) throws Exception;
	
	public void deleteImg(String bno) throws Exception;
	
	public void deleteBoard(String bno) throws Exception;
	
////CommunityDAO /////
	
	public List<CommunityVO> CommunityAll() throws Exception;
	
	public void insertcboard(CommunityVO cvo) throws Exception;
	
	public CommunityVO read(Integer cbno) throws Exception;
	
	public void update(CommunityVO cvo) throws Exception;
	
	public void delete(Integer cbno) throws Exception;
	
////CommReplyDAO ////
	
	public void rplyDelete(Integer brno)throws Exception;
	
	public void increaseCount(Integer cbno) throws Exception;
	
	public int clistCountCriteria(Criteria cri) throws Exception;
	
	public List<CommunityVO> communitylistcri(Criteria cri) throws Exception;
	
	public void registerReply(CommunityReplyVO creplyvo) throws Exception;
	
	public int rlistCountCriteria(Criteria cri) throws Exception;
	
	public List<CommunityReplyVO> readReply(Criteria cri) throws Exception;
}
