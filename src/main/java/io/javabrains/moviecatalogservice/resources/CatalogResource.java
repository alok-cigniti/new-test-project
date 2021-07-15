package io.javabrains.moviecatalogservice.resources;

import io.javabrains.moviecatalogservice.models.CatalogItem;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/catalog")
@Profile("dev")
public class CatalogResource {
	@Value("${value.from.file}")
	private String valueFromFile;

	@RequestMapping("/{userId}")
	public List<CatalogItem> getCatalog(@PathVariable("userId") String userId) {
		return Arrays.asList(new CatalogItem("Alok", "developer", 100),
				new CatalogItem("Manoj", "testing", 101),
				new CatalogItem("Alok", "testing", 105),
				new CatalogItem("Shivam", "architect", 102));
	}

	@RequestMapping("/count")
	public int getCatalogSize() {
		return Arrays.asList(new CatalogItem("Alok", "developer", 100),
				new CatalogItem("Manoj", "testing", 101),
				new CatalogItem("Shivam", "architect", 102)).size();
	}

	@RequestMapping("/env")
	public String getEnvValue() {
		return valueFromFile;
	}
}