package org.kkk.service;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import org.kkk.domain.BoardAttachVO;
import org.kkk.mapper.BoardAttachMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class FileCheckTask {

	@Autowired
	private BoardAttachMapper attachMapper;
	
	private String getFolderYesterDay() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, 0);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("_", File.separator);
	}
	
//	@Scheduled(cron = "40 * * * * *")
//	public void checkFiles() throws Exception{
//		log.warn("file check task run..........");
//		log.warn("1========================");
//		
//		//file list in database
//		List<BoardAttachVO> fileList = attachMapper.getOldFiles();
//		
//		//ready for check file in directory with database file list
//		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("C:\\upload",vo.getUploadPath(),vo.getUuid() + "_" + vo.getFileName()))
//		.collect(Collectors.toList());
//		
//		//image file has thumbnail file
//		fileList.stream().filter(vo -> vo.isFileType() == true).map(vo -> Paths.get("C:\\upload",vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName()))
//		.forEach(p -> fileListPaths.add(p));
//		
//		log.warn("2================================");
//		
//		fileListPaths.forEach(p -> log.warn(p));
//		
//		//files in yesterday directory
//		File targetDir = Paths.get("C:\\upload",getFolderYesterDay()).toFile();
//		
//		File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
//		
//		log.warn("3====================================");
//		
//		for (File file : removeFiles) {
//			log.warn(file.getAbsolutePath());
//			file.delete();
//		}//for
//		
//	}
	
}
