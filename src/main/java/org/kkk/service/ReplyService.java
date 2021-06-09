package org.kkk.service;

import java.util.List;

import org.kkk.domain.Criteria;
import org.kkk.domain.ReplyPageDTO;
import org.kkk.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public List<ReplyVO> getList(Criteria cri,Long rno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);
	
}
