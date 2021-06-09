package org.kkk.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.kkk.domain.SampleDTO;
import org.kkk.domain.SampleDTOList;
import org.kkk.domain.SampleVO;
import org.kkk.domain.Ticket;
import org.kkk.domain.TodoDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

	@GetMapping(value = "/getText" , 
				produces = "text/plain; charset=UTF-8")
	public String getText() {
		
		log.info("mime type : " + MediaType.TEXT_PLAIN_VALUE);
		
		return " hi~~";
	}
	
	@GetMapping(value = "/getSample",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public SampleVO getSample() {		
		return new SampleVO(112,"스타","로드");		
	}
	
	@GetMapping(value = "/getSample2")
	public SampleVO getSample2() {
		return new SampleVO(113,"로캣","라쿤");
	}
	
	@GetMapping(value = "/getList")
	public List<SampleVO> getList(){
		return IntStream.range(1, 10).mapToObj(i -> new SampleVO(i, i+"first", i+"last")).collect(Collectors.toList());
	}
	
	
	
	@GetMapping(value = "/getMap")
	public Map<String, SampleVO> getMap(){
		
		Map<String, SampleVO> map = new HashMap<>();
		map.put("First", new SampleVO(111, "그루트","주니어"));
		
		return map;
	}
	
	@GetMapping(value = "/check",
				params = {"height","weight"})
	public ResponseEntity<SampleVO> check(Double height,Double weight){
		
		SampleVO vo = new SampleVO(0,""+height,""+weight);
		
		ResponseEntity<SampleVO> result = null;
		
		if (height < 150) {
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		}	else	{
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
		}
		
		return result;
	}
	
	@GetMapping("/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat")String cat,
							@PathVariable("pid")Integer pid) {
		return new String[] {"category: " + cat , "productud: " + pid};
	}
	
	@PostMapping("/ticket")
	public Ticket convert(@RequestBody Ticket ticket) {
		
		log.info("convert.......ticket" + ticket);
		
		return ticket;
	}
	
	@RequestMapping("")
	public void basic() {
		log.info("basic........");
	}
	
	@RequestMapping(value = "/basic", method = {RequestMethod.GET,RequestMethod.POST})
	public void basicGet() {
		log.info("basic get......");
		
	}
	
	@GetMapping("/basicOnlyGet")
	public void basicGet2() {
		log.info("basic get only get..............");
	}
	
	@GetMapping("/ex01")
	public String ex01(SampleDTO dto) {
		log.info("" + dto);
		
		return "ex01";
	}
	
	@GetMapping("/ex02")
	public String ex02(	@RequestParam("name") String name,
						@RequestParam("age") int age) {
		
		log.info("name : " + name);
		log.info("age : " + age);
		
		return "ex02";	
	}
	
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids")ArrayList<String> ids) {
		
		log.info("ids : " + ids);
		
		return "ex02List";
	}
	
	@GetMapping("/ex02Array")
	public String ex02Array(@RequestParam("ids")String[] ids) {
		
		log.info("array ids: " + Arrays.toString(ids));
		
		return "ex02Array";
	}
	
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		
		log.info("list dtos: " + list);
		
		return "ex02Bean";
	}
	
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		log.info("todo : " + todo);
		
		return "ex03";
	}
	
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto ,@ModelAttribute("page") int page) {
		
		log.info("dto: " + dto);
		log.info("page : " + page);
		
		return "/sample/ex04";
	}
	
	@GetMapping("/ex05")
	public void ex05() {
		log.info("ex05...........");
	}
	
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		
		log.info("exo6......");
		
		SampleDTO dto = new SampleDTO();
		dto.setAge(10);
		dto.setName("hong gil dong");
		
		return dto;
	}
	
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07(){
		
		log.info("exo7......");
		
		String msg = "{\"name\":\"hong gil dong\"}";
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg,header,HttpStatus.OK);
	}
	
	@GetMapping("exUpload")
	public void exUpload() {
		log.info("exupload.......");
	}
	
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		files.forEach(file -> {
			log.info("-----------------");
			log.info("name:" + file.getOriginalFilename());
			log.info("size:" + file.getSize());
			
		});
	}
	
	@GetMapping("/all")
	public void doAll() {
		log.info("do all can acees everybody");
	}
	
	@GetMapping("/member")
	public void doMember() {
		log.info("login member");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("admin only");
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/annoMember")
	public void doMember2() {
		
		log.info("logined annotation member");
	}
	
	@Secured("ROLE_MEMBER")
	@GetMapping("/annoAdmin")
	public void doAdmin2() {
		
		log.info("logined annotation only");
	}
	
	
}
