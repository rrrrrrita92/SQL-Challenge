/*

two tables：notification_clicked, ec_purchse 
計算「商品 X 」的推播購買轉換率。
 轉換率公式:可歸因購買數 / 總推播點擊人數
 (點擊推播後 30 分鐘內完成的購買行為,才視為可歸因購買行為。)

notification_clicked

Name Type Description
event str Name of this event. Should always be "notification_clicked".
product str Name of promoted product.
memberId int ID of the member who clicked the notification.
createdAt timestamp At which time the event took place. It should follow ISO 8601 format and be converted to UTC.

ec_purchased

Name Type Description
event str Name of this event. Should always be "ec_purchased".
product str Name of purchased product.
memberId int ID of the member who purchased the product.
createdAt timestamp At which time the event took place. It should follow ISO 8601 format and be converted to UTC.

 */

SELECT product, 
       ROUND(CAST(COUNT(purchased_datetime) AS float) / CAST(COUNT(DISTINCT clicked_userId) AS float), 2) AS attributed_CVR
FROM 
(
    SELECT N.event, 
    	   N.product, 
    	   N.memberId AS clicked_userId, 
    	   N.createdAt AS clicked_datetime, 
         E.memberId AS purchased_userId, 
           E.createdAt AS purchased_datetime
    FROM notification_clicked N
    INNER JOIN ec_purchased E
    	ON N.product = E.product 
    	AND N.memberId = E. memberId
    WHERE E.createdAt <= DATEADD(minute, 30, N.createdAt)
    	AND E.createdAt >= N.createdAt
) AS attribution 
GROUP BY product
HAVING product = 'X'
;

