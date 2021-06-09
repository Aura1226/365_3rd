package org.kkk.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.kkk.domain.BoardVO;
import org.kkk.domain.Criteria;
import org.kkk.domain.ReplyVO;

public interface BoardMapper {

//	@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
		
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);
	
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno")Long bno,
								@Param("amount")int amount);
	
	
}
