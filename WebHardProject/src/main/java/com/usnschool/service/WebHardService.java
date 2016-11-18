package com.usnschool.service;

import java.util.List;

import com.usnschool.domain.BoardFileVO;
import com.usnschool.domain.BoardImgVO;
import com.usnschool.domain.BoardVO;
import com.usnschool.domain.CommunityReplyVO;
import com.usnschool.domain.CommunityVO;
import com.usnschool.domain.Criteria;
import com.usnschool.domain.UserDownloadVO;
import com.usnschool.domain.UserVO;

public interface WebHardService { 
	
	public void fileUpLoad(BoardFileVO vo) throws Exception;
	
	public UserVO login(String id, String password) throws Exception;
	
	public void insertboard(BoardVO boardvo) throws Exception;
	
	public String getLastBno() throws Exception;
	
	public void imgUpLoad(BoardImgVO boardimgvo) throws Exception;
	
	public String idoverlapcheck(String id) throws Exception;
	
	public void register(UserVO uservo) throws Exception;

	public List<BoardVO> listAll() throws Exception;
	
	public List<BoardVO> listCriteria(Criteria cri)throws Exception;
	
	public int listCountCriteria(Criteria cri)throws Exception;
	
	public BoardVO getBoardvo(Integer bno) throws Exception;
	
	public List<BoardFileVO> getboardfilevo(Integer bno) throws Exception;
	
	public List<BoardImgVO> getboardimgvo(Integer bno) throws Exception;
	
	public String getfilepath(Integer bfno) throws Exception;
	
	public void calpoint(String loginid, String writer, int bfno, int bno, int point, String filename) throws Exception;
	
	public List<UserDownloadVO> getuserdownload(String loginid, int bno) throws Exception;
	
	public UserVO getBoardVOById(String id) throws Exception;
	
	public void changeUserInfo(UserVO uservo) throws Exception;
	
	public UserVO checkid(String id , String password) throws Exception;
	
	public void deleteid(String id) throws Exception;
	
	public void changegrade(String id) throws Exception;
	
	public List<UserDownloadVO> getUserDownList(String id) throws Exception;
	
	public void deleteBoard(String bno) throws Exception;
	
	//////////////////////////// Community 관련부분  /////////////////////
	
	public List<CommunityVO> CommunityAll() throws Exception;
	
	public void regist(CommunityVO cvo) throws Exception;
	
	public CommunityVO read(Integer cbno)throws Exception;
	
	public void modify(CommunityVO cvo)throws Exception;
	
	public void remove (Integer cbno) throws Exception;
	
	public void removeReply (Integer cbrno) throws Exception;
	
	public void increaseCount(Integer cbno) throws Exception;
	
	public int clistCountCriteria(Criteria cri) throws Exception;
	
	public List<CommunityVO> communitylistcri(Criteria cri) throws Exception;
	
	public void registerReply(CommunityReplyVO creplyvo) throws Exception;
	
	public int rlistCountCriteria(Criteria cri) throws Exception;
	
	public List<CommunityReplyVO> readReply(Criteria cri) throws Exception;
}


