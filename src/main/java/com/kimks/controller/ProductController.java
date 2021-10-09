package com.kimks.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kimks.domain.CategoryVO;
import com.kimks.domain.ProductVO;
import com.kimks.service.ProductService;
import com.kimks.util.Criteria;
import com.kimks.util.PageDTO;
import com.kimks.util.UploadFileUtils;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/product/*")
public class ProductController {

	private ProductService service;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@ResponseBody
	@GetMapping(value = "/subCategory/{mainCategory}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategory") Integer cate_code_pk) {
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cate_code_pk), HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	} 
	
	@GetMapping(value= "/list")
	public String list(@ModelAttribute("subCategory") Integer subCategory, Model model, Criteria cri) throws Exception{
		cri.setAmount(4);
		
		int total = service.getTotalCount(subCategory);
		
		PageDTO pageMaker = new PageDTO(total, cri);
		
		List<ProductVO> list = service.getListWithPaging(cri, subCategory);
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", list);
		
		return "/product/list";
	}
	
	@GetMapping(value= "/find")
	public String find(Model model, Criteria cri) throws Exception{
		
		cri.setAmount(4);
		
		int total = service.findTotal(cri);
		
		PageDTO pageMaker = new PageDTO(total, cri);
		
		List<ProductVO> list = service.findListWithPaging(cri);
		
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", list);
		model.addAttribute("total", total);
		return "/product/find";
	}
	
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(fileName, uploadPath);
		
		return entity;
	}
	
	@ResponseBody
	@GetMapping("/displayOriginalFile")
	public ResponseEntity<byte[]> displayOriginalFile(String fileName) throws Exception{
		ResponseEntity<byte[]> entity = null;
		String path = fileName.substring(0,12);
		fileName = fileName.substring(fileName.indexOf("_")+1);
		entity = UploadFileUtils.getFileByte(path+fileName, uploadPath);
		
		return entity;
	}
	
	@GetMapping("/get")
	public void productDetail(@ModelAttribute("cri") Criteria cri,@RequestParam("pdt_code") Integer pdt_code , Model model) throws Exception{
		ProductVO vo = service.getProduct(pdt_code);
		Integer categoryCode = vo.getCate_prt();
		List<CategoryVO> subCategoryList = service.subCategory(categoryCode);

		model.addAttribute("mainCategory", service.mainCategory());
		model.addAttribute("subCategory", subCategoryList);
		model.addAttribute("productVO",vo);
		
	}
}
