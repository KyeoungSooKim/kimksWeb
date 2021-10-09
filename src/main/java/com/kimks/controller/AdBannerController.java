package com.kimks.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimks.domain.BannerVO;
import com.kimks.service.BannerService;
import com.kimks.util.MediaUtils;
import com.kimks.util.UploadFileUtils;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("admin/banner/**")
public class AdBannerController {

	private BannerService service;
	
	@Resource(name = "uploadBannerPath")
	private String uploadPath;
	
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
	
	@GetMapping("/insert")
	public void insert() {}
	
	@PostMapping("/insert")
	public String insert(BannerVO vo, RedirectAttributes rttr) throws Exception{
		String url = "redirect:/admin/banner/edit";
		
		if(vo.getFile1().getSize() == 0) { //파일이 첨부되었는지 검사
			rttr.addFlashAttribute("msg", "zeroFile");
			url = "redirect:/admin/banner/insert";
		}else {
			String formatName = vo.getFile1().getOriginalFilename().substring(vo.getFile1().getOriginalFilename().lastIndexOf(".")+1);
			if(MediaUtils.getMediaType(formatName) != null) {//이미지 형식인지 검사
				
				vo.setBn_img(UploadFileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
				service.insert(vo);
			}else {
				rttr.addFlashAttribute("msg", "notImage");
				url = "redirect:/admin/banner/insert";
			}
			
		}
		
		
		return url;
	}
	
	@GetMapping("/delete")
	public String delete(Long bn_code, String bn_img) {
		
		service.delete(bn_code);
		UploadFileUtils.deleteFile(uploadPath, bn_img);
		return "redirect:/admin/banner/edit";
	}
	
	@GetMapping("/edit")
	public void edit(Model model) {
		
		List<BannerVO> list = service.getAll();
		
		
		model.addAttribute("list", list);
	}
	
	//배너수정
	@PostMapping("/modify")
	public String modify(@RequestParam("bn_code") List<Long> bn_code, @RequestParam("bn_order") List<Integer> bn_order, 
			@RequestParam("bn_img") List<String> bn_img, @RequestParam("file1") MultipartFile[] file1, RedirectAttributes rttr) throws Exception{
		
	BannerVO vo = new BannerVO(); //DB에 파라미터 전달하기 위한 배너객체 생성
	String formatName = "";
	for(int i=0; i<bn_order.size(); i++) {
		
		vo.setBn_code(bn_code.get(i)); //배너코드 세팅
		vo.setBn_order(bn_order.get(i)); //배너순서 세팅
		
		if(file1[i].getSize()==0) { //첨부한 파일이 없는 경우
			vo.setBn_img(bn_img.get(i));
		}else { //첨부한 파일이 있는 경우
			formatName = file1[i].getOriginalFilename().substring(file1[i].getOriginalFilename().lastIndexOf(".")+1);
			if(MediaUtils.getMediaType(formatName) != null) {
				//배너객체의 이미지 필드에 첨부한 이미지 업로드와 동시에 파일명 생성하여 세팅
				vo.setBn_img(UploadFileUtils.uploadFile(uploadPath, file1[i].getOriginalFilename(), file1[i].getBytes()));
				UploadFileUtils.deleteFile(uploadPath, bn_img.get(i)); //수정 전 이미지 업로드폴더에서 삭제
			}else {//첨부한 파일이 이미지가 아닌 경우
				vo.setBn_img(bn_img.get(i));
				rttr.addFlashAttribute("msg", "notImage");
			}	
		}
		service.modify(vo);
		}
		return "redirect:/admin/banner/edit";
	}
}
