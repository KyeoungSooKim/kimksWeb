package com.kimks.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;

import lombok.extern.log4j.Log4j;

//업로드 기능 관련 작업 담당 클래스
@Log4j
public class UploadFileUtils {
									//D:\\upload\\real
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws IOException {
		
		//파일명 중복방지하기위해 랜덤문자열 반환하여 파일명에 추가해 사용하는 용도
		UUID uid = UUID.randomUUID();
		
		String savedName = uid.toString() + "_" + originalName;
		//752fb691-4aae-4ed0-a509-02ca005954c0_4.jpg
		
		//업로드 날짜별 폴더 생성하여 관리
		String savedPath = calcpath(uploadPath); // "\2021\08\23"
		
		//업로드작업
		File target = new File(uploadPath + savedPath, savedName);
		 				// D:\\upload\\real\2021\08\23", 752fb691-4aae-4ed0-a509-02ca005954c0_4.jpg 껍데기
		FileCopyUtils.copy(fileData, target); //생성했던 파일 객체 껍데기에 데이터 복사
		
		//이미지 파일 여부에 따라 썸네일작업 진행
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1); // a.jpg
		//확장자 이름
		String uploadedFileName = null; //썸네일 이미지작업에 의한 파일명
		
		if(MediaUtils.getMediaType(formatName) != null) {
			//이미지파일이므로 썸네일작업
			uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
		}else {
			//일반파일작업
			uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		return uploadedFileName;
	}

	private static String makeIcon(String uploadPath, String savedPath,
											String savedName) {
									
		String iconName = uploadPath + savedPath + File.separator + savedName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
									}

	private static String makeThumbnail(String uploadPath, String savedPath,
											String savedName) throws IOException {
										
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath+savedPath, savedName));
		
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		
		//썸네일이미지 파일명
		String thumbnailName = uploadPath + savedPath + File.separator + "s_" + savedName;
		
		String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
		
		ImageIO.write(destImg, formatName.toUpperCase(), new File(thumbnailName));
		
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
									}

	// 날짜별 폴더관리 기능
	private static String calcpath(String uploadPath) {
		// TODO Auto-generated method stub
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		// "\2021"
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		// "\2021\08"
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		// "\2021\08\23"
		makeDir(uploadPath, yearPath, monthPath, datePath);
		return datePath;
	}

	//날짜별 폴더생성기능					D:\\upload\\real
	private static void makeDir(String uploadPath, String... paths) {
		// TODO Auto-generated method stub
		
		if(new File(paths[paths.length-1]).exists()) {
			return;
		}
		
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			/*
			 1) D:\\upload\real\2021
			 2) D:\\upload\real\2021\08
			 3) D:\\upload\real\2021\08\23
			  */
			if(! dirPath.exists()) {
				dirPath.mkdir();
			}
		}
	}
	public static ResponseEntity<byte[]> getFileByte(String fileName, String uploadPath) throws Exception {
		ResponseEntity<byte[]> entity = null;
		
		InputStream in = null;
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		//이미지파일인지 확인
		MediaType mType = MediaUtils.getMediaType(formatName);
		
		//클라이언트에게 보내는 데이터에 대한 부연설명
		HttpHeaders headers = new HttpHeaders();
		
		//업로드된 파일을 참조하는 파일입력스트림 객체 생성
		in = new FileInputStream(uploadPath + fileName);
		
		if(mType != null) {
			headers.setContentType(mType);
		}else {
			fileName = fileName.substring(fileName.indexOf("_")+1);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
		}
		
		entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		return entity;
	}
	
	//파일삭제
	public static void deleteFile(String uploadPath, String fileName) {
		String front = fileName.substring(0,12);
		String end = fileName.substring(14);
		String origin = front + end;
		
		new File(uploadPath + origin.replace('/', File.separatorChar)).delete();
		new File(uploadPath + fileName.replace('/', File.separatorChar)).delete();
	}
	
}
