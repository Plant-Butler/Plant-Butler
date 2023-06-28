package com.plant.service;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.*;
import com.amazonaws.util.IOUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Service
public class S3Service {

    @Value("${cloud.aws.s3.bucket}")
    private String bucket;

    @Value("${s3.folderNames}")
    private String s3FolderNames;

    private final AmazonS3 amazonS3;
    private final AmazonS3Client s3Client;

    public S3Service(AmazonS3 amazonS3, AmazonS3Client s3Client) {
        this.amazonS3 = amazonS3;
        this.s3Client = s3Client;
    }

    public String[] getS3FolderNames() {
        return s3FolderNames.split(",");
    }

    /* 업로드 */
    public String upload(MultipartFile multipartFile, String type, int seq) throws IOException {
        String s3FileName =  type + "-" + seq + "-" + multipartFile.getOriginalFilename();
        String folder = null;

        ObjectMetadata objectMeta = new ObjectMetadata();
        objectMeta.setContentLength(multipartFile.getInputStream().available());

        String[] folderNames = this.getS3FolderNames();
        // 커뮤니티
        if(type.equals("post")) {
            folder = folderNames[2];
        // 식물일기
        } else if(type.equals("diary")) {
            folder = folderNames[3];
        // 내 식물
        } else if(type.equals("myplant")) {
            folder = folderNames[4];
        // 식물병 & 병해충 판별
        } else if(type.equals("diagnosis")) {
            folder = folderNames[5];
        }

        amazonS3.putObject(bucket, folder + "/" + s3FileName, multipartFile.getInputStream(), objectMeta);
        return s3FileName;
    }

    /* 삭제 */
    public void delete(String oriFileName, String type, int seq){
        String s3FileName =  type + "-" + seq + "-" + oriFileName;
        String folder = null;

        String[] folderNames = this.getS3FolderNames();
        // 커뮤니티
        if(type.equals("post")) {
            folder = folderNames[2];
        // 식물일기
        } else if(type.equals("diary")) {
            folder = folderNames[3];
        // 내 식물
        } else if(type.equals("myplant")) {
            folder = folderNames[4];
        // 식물병 & 병해충 판별
        } else if(type.equals("diagnosis")) {
            folder = folderNames[5];
        }

        DeleteObjectRequest request = new DeleteObjectRequest(bucket, folder + "/" + s3FileName);
        amazonS3.deleteObject(request);
    }

    /* URL 조회 */
    public String getUrl(String oriFileName, String type, int seq) {
        String fileName = type + "-" + seq + "-" + oriFileName;
        String folder = null;

        String[] folderNames = this.getS3FolderNames();
        // 커뮤니티
        if(type.equals("post")) {
            folder = folderNames[2];
        // 식물일기
        } else if(type.equals("diary")) {
            folder = folderNames[3];
        // 내 식물
        } else if(type.equals("myplant")) {
            folder = folderNames[4];
        // 식물병 & 병해충 판별
        } else if(type.equals("diagnosis")) {
            folder = folderNames[5];
        }

        return s3Client.getUrl(bucket,folder + "/" +fileName).toString();
    }

    /* 파일명으로만 URL 조회 */
    public String getUrlwithFolder(String type, String oriFileName) {

        String folder = null;
        String[] folderNames = this.getS3FolderNames();
        if(type.equals("diagnosis")) {
            folder = folderNames[1].trim();
        } else {
            folder = folderNames[0];
        }

        return s3Client.getUrl(bucket, folder.trim() + "/" + oriFileName + ".jpg").toString();
    }

    /* 첨부파일 다운로드 */
    public ResponseEntity<byte[]> getObject(String oriFileName, String type, int seq) throws IOException {
        String[] folderNames = this.getS3FolderNames();
        String s3FileName = folderNames[2] + "/" + type + "-" + seq + "-" + oriFileName;

        S3Object o = amazonS3.getObject(new GetObjectRequest(bucket, s3FileName));
        S3ObjectInputStream objectInputStream = ((S3Object) o).getObjectContent();
        byte[] bytes = IOUtils.toByteArray(objectInputStream);

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        httpHeaders.setContentLength(bytes.length);
        httpHeaders.setContentDispositionFormData("attachment", oriFileName);

        return new ResponseEntity<>(bytes, httpHeaders, HttpStatus.OK);
    }

}
