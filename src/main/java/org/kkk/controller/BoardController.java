package org.kkk.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.kkk.domain.BoardAttachVO;
import org.kkk.domain.BoardVO;
import org.kkk.domain.Criteria;
import org.kkk.domain.PageDTO;
import org.kkk.service.BoardService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	
	
	private BoardService service;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		log.info("list");
//		model.addAttribute("list",service.getList());
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list",service.getList(cri));
//		model.addAttribute("pageMaker",new PageDTO(cri, 123));
		
		int total = service.getTotal(cri);
		
		log.info("total: " + total);
		
		model.addAttribute("pageMaker",new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register() {
		
	}
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, RedirectAttributes rttr) {
		
		log.info("====================");
		log.info("register : " + board);
		
		if (board.getAttachList() != null) {
			board.getAttachList().forEach(attach -> log.info(attach));
		}
		
		log.info("====================");
		
		service.register(board);
		
		rttr.addFlashAttribute("result",board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/get , modify");
		model.addAttribute("board", service.get(bno));
	}
	
	@PreAuthorize("principal.username == #board.writer || principal.username eq 'admin90'")
	@PostMapping("/modify")
	public String modify(BoardVO board,@ModelAttribute("cri")Criteria cri,RedirectAttributes rttr) {
		log.info("modify:" + board);
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		
//		rttr.addAttribute("pageNum"	, cri.getPageNum());
//		rttr.addAttribute("amount"	, cri.getAmount());
//		rttr.addAttribute("type"	, cri.getType());
//		rttr.addAttribute("keyword"	, cri.getKeyword());
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer || principal.username eq 'admin90'")
	@PostMapping("/remove") // 	첨부파일 목록 확보 > db에서 게시물과 첨부파일 데이터 삭제
							//	원본 삭제 후 섬네일 추가 삭제
	public String remove(@RequestParam("bno") Long bno , RedirectAttributes rttr, Criteria cri, String writer) {
		
		log.info("remove..." + bno);
		
		List<BoardAttachVO> attachList = service.getAttachList(bno);
		
		if (service.remove(bno)) {
			//delete attach file
			deleteFiles(attachList);
			rttr.addFlashAttribute("result","success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList",
				produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
		
		log.info("getattachlist : " + bno);
		
		return new ResponseEntity<>(service.getAttachList(bno),HttpStatus.OK);
	}
	
	private void deleteFiles(List<BoardAttachVO> attachList) { 
		if (attachList == null || attachList.size() == 0) {
			return;
		}//if
		
		log.info("delete attach files............");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			
			try {
				
				Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\" + attach.getUuid() + "_" + attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if (Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\s_" + attach.getUuid() + "_" + attach.getFileName());
					
					Files.delete(thumbNail);
					
				}//if
				
			} catch (Exception e) {
				// TODO: handle exception
				log.error("delete file error" + e.getMessage());
			}//catch
			
		});//foreach
		
	}
	
	
	
	
}
