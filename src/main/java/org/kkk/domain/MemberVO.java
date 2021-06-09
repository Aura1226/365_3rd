package org.kkk.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {

	private String userid,userpw,userName;
	
	private boolean enabled;
	
	private Date regDate,updateDate;
	
	private List<AuthVO> authList;
	
}
