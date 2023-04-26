package com.plant.vo;

import java.sql.Timestamp;

public class PostVo {

    private int postId;

    private String userId;
    private String postTitle;
    private String postContent;
    private String postTag;
    private String postImage;
    private String postFile;
    private Timestamp postDate;
    private int readCount;
    private int flag; // 신고 수

    public PostVo() {}

    public PostVo(int postId, String userId, String postTitle, String postContent, String postTag, String postImage, String postFile, Timestamp postDate, int readCount, int flag) {
        this.postId = postId;
        this.userId = userId;
        this.postTitle = postTitle;
        this.postContent = postContent;
        this.postTag = postTag;
        this.postImage = postImage;
        this.postFile = postFile;
        this.postDate = postDate;
        this.readCount = readCount;
        this.flag = flag;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public String getPostTag() {
        return postTag;
    }

    public void setPostTag(String postTag) {
        this.postTag = postTag;
    }

    public String getPostImage() {
        return postImage;
    }

    public void setPostImage(String postImage) {
        this.postImage = postImage;
    }

    public String getPostFile() {
        return postFile;
    }

    public void setPostFile(String postFile) {
        this.postFile = postFile;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }

    public int getReadCount() {
        return readCount;
    }

    public void setReadCount(int readCount) {
        this.readCount = readCount;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }
}
