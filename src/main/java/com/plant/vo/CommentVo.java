package com.plant.vo;

import java.sql.Timestamp;

public class CommentVo {

    private int commentId;
    private String commentContent;
    private Timestamp commentDate;
    private int flag; // 신고 수

    public CommentVo() {}

    public CommentVo(int commentId, String commentContent, Timestamp commentDate, int flag) {
        this.commentId = commentId;
        this.commentContent = commentContent;
        this.commentDate = commentDate;
        this.flag = flag;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Timestamp getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(Timestamp commentDate) {
        this.commentDate = commentDate;
    }

    public int getFlag() {
        return flag;
    }

    public void setFlag(int flag) {
        this.flag = flag;
    }
}
