package dto;

public class EmotionLogDTO {
    private int logId;
    private int userId;
    private String emotion;
    private String content;
    private String createdAt;
    private String fileName;

    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getEmotion() { return emotion; }
    public void setEmotion(String emotion) { this.emotion = emotion; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getCreatedAt() { return createdAt; }  
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; } 

    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }
}
