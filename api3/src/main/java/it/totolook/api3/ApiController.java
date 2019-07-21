package it.totolook.api3;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ApiController {

	static Logger logger = LoggerFactory.getLogger(ApiController.class);
	
	@GetMapping("/")
	public String endpoint () {
		logger.info(System.getenv("API3_TEXT") != null ? System.getenv("API3_TEXT") : "api3 default text" );
		return  System.getenv("API3_TEXT") != null ? System.getenv("API3_TEXT") : "Sit amet" ;
	}
}
