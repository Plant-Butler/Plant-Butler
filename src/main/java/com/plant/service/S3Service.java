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

    private final AmazonS3 amazonS3;
    private final AmazonS3Client s3Client;

    public S3Service(AmazonS3 amazonS3, AmazonS3Client s3Client) {
        this.amazonS3 = amazonS3;
        this.s3Client = s3Client;
    }

    /* 업로드 */
    public String upload(MultipartFile multipartFile, String type, int seq) throws IOException {
        String s3FileName =  type + "-" + seq + "-" + multipartFile.getOriginalFilename();

        ObjectMetadata objectMeta = new ObjectMetadata();
        objectMeta.setContentLength(multipartFile.getInputStream().available());

        amazonS3.putObject(bucket, s3FileName, multipartFile.getInputStream(), objectMeta);
        return s3FileName;
    }

    /* 삭제 */
    public void delete(String oriFileName, String type, int seq){
        String s3FileName =  type + "-" + seq + "-" + oriFileName;
        DeleteObjectRequest request = new DeleteObjectRequest(bucket, s3FileName);
        amazonS3.deleteObject(request);
    }

    /* URL 조회 */
    public String getUrl(String oriFileName, String type, int seq) {
        String fileName = type + "-" + seq + "-" + oriFileName;
        return s3Client.getUrl(bucket, fileName).toString();
    }

    /* 첨부파일 다운로드 */
    public ResponseEntity<byte[]> getObject(String oriFileName, String type, int seq) throws IOException {
        S3Object o = amazonS3.getObject(new GetObjectRequest(bucket, type + "-" + seq + "-" + oriFileName));
        S3ObjectInputStream objectInputStream = ((S3Object) o).getObjectContent();
        byte[] bytes = IOUtils.toByteArray(objectInputStream);

        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        httpHeaders.setContentLength(bytes.length);
        httpHeaders.setContentDispositionFormData("attachment", oriFileName);

        return new ResponseEntity<>(bytes, httpHeaders, HttpStatus.OK);
    }

}
