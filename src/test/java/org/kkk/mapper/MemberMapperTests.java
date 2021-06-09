package org.kkk.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.kkk.config.RootConfig;
import org.kkk.domain.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Log4j
public class MemberMapperTests {

	@Autowired
	private MemberMapper mapper;
	
	@Test
	  public void testRead() {
	    
	    MemberVO vo = mapper.read("admin90");
	    
	    log.info(vo);
	    
	    vo.getAuthList().forEach(authVO -> log.info(authVO));
	    
	  }
	
}
