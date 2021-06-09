package org.kkk.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {

	private Long rno;
	private Long bno;
	
	private String reply,replyer;
	private Date replyDate,updateDate;
	
	
}
