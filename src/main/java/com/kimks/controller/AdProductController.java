package com.kimks.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kimks.domain.CategoryVO;
import com.kimks.domain.ProductVO;
import com.kimks.service.AdOrderService;
import com.kimks.service.AdProductService;
import com.kimks.util.Criteria;
import com.kimks.util.PageDTO;
import com.kimks.util.UploadFileUtils;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/admin/product/*")
public class AdProductController {

	private AdProductService service;
	private AdOrderService o_service;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@GetMapping("/insert")
	public void productInsert(Model model) {
		
		model.addAttribute("mainCategory", service.mainCategory());
	}
	
	@ResponseBody
	@GetMapping(value = "/subCategory/{mainCategoryCode}", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CategoryVO>> subCategory(@PathVariable("mainCategoryCode") Integer cate_code) {
		ResponseEntity<List<CategoryVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCategory(cate_code), HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	} 
	
	@PostMapping("/imgUpload")
	public void ckeditor_upload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		res.setCharacterEncoding("utf-8");
		res.setContentType("/text/html;charset=utf-8");
		
		try {
			String fileName = upload.getOriginalFilename(); //클라이언트에서 보내온 파일명
			byte[] bytes = upload.getBytes(); // 파일을 바이트배열로 읽어들임
			
			String uploadPath = "/usr/local/tomcat/tomcat-9/webapps/upload/"; //프로젝트에 해당하는 톰캣의 물리적주소
			File uploadFolder = new File(uploadPath);
			if(!uploadFolder.exists()) {
				uploadFolder.mkdir();
			}
			uploadPath = uploadPath + fileName;
			
			//log.info(uploadPath); //실제업로드경로
			
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			
			//서버에서 response 객체에 printWriter 객체를 참조해 정보를 보낼때 사용
			printWriter = res.getWriter();
			String fileUrl = "/ckeditor/upload/"+ fileName; //servlet-context.xml 에서 매핑 설정
			
			//서버에서 ckeditor에게 보내는 업로드된 파일정보 {"filename" : "fileName", "uploaded" : 1, "url" : "fileUrl"}
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(out != null) {
				try {out.close();}catch (Exception e) {e.printStackTrace();}
			}
			if(printWriter != null) {
				try {printWriter.close();}catch (Exception e) {e.printStackTrace();}
			}
		}
	}
	@GetMapping("/list")
	public void productList(Criteria cri, Model model) {
		
		int total = service.getTotal(cri);
		//log.info("total: "+total);
		
		PageDTO pageMaker = new PageDTO(total, cri);
		
		if(cri.getPageNum() > pageMaker.getRealEnd()) {
			cri.setPageNum(pageMaker.getRealEnd());
		}
		
		List<ProductVO> list = service.getListWithPaging(cri);
		model.addAttribute("total", total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("list", list);
	}
	
	@PostMapping("/insert")
	public String productInsert(ProductVO vo, RedirectAttributes rttr) throws Exception{
		//log.info(vo);
		vo.setPdt_img(UploadFileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
		if(vo.getPdt_buy().equals("on")) {
			vo.setPdt_buy("Y");
		}else {
			vo.setPdt_buy("N");
		}
		//log.info(vo.toString());
		
		service.insert(vo);
		rttr.addFlashAttribute("msg", "success");
		
		return "redirect:/admin/product/list";
	}
	
	@PostMapping("/edit")
	public String productEdit(Criteria cri, ProductVO vo, RedirectAttributes rttr) throws Exception{
		
		
		if(vo.getPdt_buy().equals("on")) {
			vo.setPdt_buy("Y");
		}else {
			vo.setPdt_buy("N");
		}
		//log.info(vo.toString());
		
		if(vo.getFile1().getSize() > 0) {
			//기존이미지 파일삭제작업
			UploadFileUtils.deleteFile(uploadPath, vo.getPdt_img());
			vo.setPdt_img(UploadFileUtils.uploadFile(uploadPath, vo.getFile1().getOriginalFilename(), vo.getFile1().getBytes()));
			
		}
		
		service.edit(vo);
		rttr.addFlashAttribute("msg", "editSuccess");
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/admin/product/list";
	}
	
	@ResponseBody
	@PatchMapping(value = "/priceModify/{pdt_code}/{pdt_price}/{pdt_discount}/{pdt_buy}")
	public ResponseEntity<String> priceModify(@PathVariable("pdt_code") Integer pdt_code,@PathVariable("pdt_price") Integer pdt_price,@PathVariable("pdt_discount") Integer pdt_discount,@PathVariable("pdt_buy") String pdt_buy) throws Exception{
		ResponseEntity<String> entity = null;
		if(pdt_buy.equals("true")) {
			pdt_buy = "Y";
		}else {
			pdt_buy = "N";
		}
		ProductVO vo = new ProductVO();
		vo.setPdt_code(pdt_code);
		vo.setPdt_price(pdt_price);
		vo.setPdt_discount(pdt_discount);
		vo.setPdt_buy(pdt_buy);
		service.priceEdit(vo);
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@ResponseBody
	@PostMapping("/priceModifyChecked") //ajax 배열로 넘어온경우
	public ResponseEntity<String> priceModifyChecked(
			@RequestParam("pdt_codeArr[]") List<Integer> pdt_codeArr,
			@RequestParam("pdt_priceArr[]") List<Integer> pdt_priceArr,
			@RequestParam("pdt_discountArr[]") List<Integer> pdt_discountArr,
			@RequestParam("pdt_buyArr[]") List<String> pdt_buyArr) {
		
		ResponseEntity<String> entity = null;
		ProductVO vo = new ProductVO();
		String pdt_buy = "";
		
		for(int i=0; i<pdt_codeArr.size(); i++) { //선택하여 넘어온 데이터 수 만큼 반복
			//상품표시 체크박스 값 확인하여 DB에 저장하기위한 문자열로 변경
			if(pdt_buyArr.get(i).equals("true")) {
				pdt_buy = pdt_buyArr.get(i).replace("true", "Y");
			}else {
				pdt_buy = pdt_buyArr.get(i).replace("false", "N");
			}
			
			vo.setPdt_code(pdt_codeArr.get(i));
			vo.setPdt_price(pdt_priceArr.get(i));
			vo.setPdt_discount(pdt_discountArr.get(i));
			vo.setPdt_buy(pdt_buy);
			service.priceEdit(vo);
		}
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		return entity;
	}
	
	@ResponseBody
	@GetMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		ResponseEntity<byte[]> entity = null;
		
		entity = UploadFileUtils.getFileByte(fileName, uploadPath);
		
		return entity;
	}
	
	//상품조회, 수정폼
	@GetMapping(value = {"/get","/edit"})
	public void edit(@ModelAttribute("cri") Criteria cri,@RequestParam("pdt_code") Integer pdt_code , Model model) throws Exception{
		ProductVO vo = service.getProduct(pdt_code);
		Integer categoryCode = vo.getCate_prt();
		List<CategoryVO> subCategory = service.subCategory(categoryCode);

		model.addAttribute("mainCategory", service.mainCategory());
		model.addAttribute("subCategory", subCategory);
		model.addAttribute("productVO",vo);
		
	}
	
	@PostMapping("delete")
	public String delete(Criteria cri, @RequestParam("pdt_code") Long pdt_code, RedirectAttributes rttr) {
		//주문내역에 상품이 존재할 시 삭제불가
		//log.info(o_service.orderDetailFind(pdt_code));
		if(o_service.orderDetailFind(pdt_code) != 0) {
			rttr.addFlashAttribute("msg", "deleteFail");
		}else {
			service.delete(pdt_code);
			rttr.addFlashAttribute("msg", "deleted");
		}
		
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		rttr.addAttribute("type",cri.getType());
		rttr.addAttribute("keyword",cri.getKeyword());
		
		return "redirect:/admin/product/list";
	}
}
