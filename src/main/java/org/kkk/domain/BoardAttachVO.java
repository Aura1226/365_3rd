package org.kkk.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

	private String uuid,uploadPath,fileName;
	
	private boolean fileType;
	
	private Long bno;
	
}
