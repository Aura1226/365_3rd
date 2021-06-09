package org.kkk.domain;

import lombok.Data;

@Data
public class AttachFileDTO {

	private String fileName, uploadPath, uuid;
	private boolean image;
	
	
}
