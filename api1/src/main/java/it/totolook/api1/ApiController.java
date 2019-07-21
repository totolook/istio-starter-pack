package it.totolook.api1;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class ApiController {

	static Logger logger = LoggerFactory.getLogger(ApiController.class);
	@GetMapping("/")
	public String endpoint () {
		String text = System.getenv("API1_TEXT") != null ? System.getenv("API1_TEXT") : "Lorem";
		// String payload =  System.getenv("API1_TEXT") != null ? System.getenv("API1_TEXT") : "api1 default text"  +" "+getApi();
		String payload =  getApi();
		logger.info("-_-_-_- " +  text + ' ' + payload + " -_-_-_-_-");
		return  text + ' ' + payload;
	}
	
	private static String getApi()
	{
		//logger.info("Sono qui!");
		    final String uri = "http://api2:8080/";

		RestTemplate restTemplate = new RestTemplate();
		String result = "Errore api2 not found";
		try {
			result = restTemplate.getForObject(uri, String.class);
		} catch (Exception e) {
			logger.error("Errore api2 not found");
		}
		

	    logger.info(result);
	    return result;
	}
}
