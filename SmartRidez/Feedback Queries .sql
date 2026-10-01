-- Query 1: Declining Feedback Ratings Over Time
-- Shows how the average rating changes month by month
SELECT 
    strftime('%Y-%m', FeedbackDate) AS Month,  -- Extract year and month from FeedbackDate
    AVG(Rating) AS AverageRating               -- Calculate the average rating for each month
FROM Feedback
GROUP BY Month                                 -- Group by each month
ORDER BY Month;                                -- Sort by month in ascending order

-- Query 2: Top Complaints from Feedback
-- Shows the most common complaints and how many times each was mentioned
SELECT 
    Comment,                                   -- The complaint text
    COUNT(Comment) AS Count                   -- Number of times the complaint was mentioned
FROM Feedback
WHERE Comment IS NOT NULL AND Comment != ''   -- Filter out null or empty comments
GROUP BY Comment                              -- Group by each complaint text
ORDER BY Count DESC                           -- Sort by the number of mentions in descending order
LIMIT 10;                                     -- Show only the top 10 complaints

-- Query 3: Average Feedback Ratings by Route
-- Shows the average rating and the total feedback count for each bus route
SELECT 
    Routes.RouteID,                           -- Unique ID for each route
    Routes.RouteName,                         -- Name of the route
    AVG(Feedback.Rating) AS AverageRating,    -- Calculate the average rating for the route
    COUNT(Feedback.FeedbackID) AS FeedbackCount -- Count the total feedback entries for the route
FROM Feedback
JOIN Rides ON Feedback.RideID = Rides.RideID -- Link feedback to rides
JOIN Routes ON Rides.RouteID = Routes.RouteID -- Link rides to routes
GROUP BY Routes.RouteID, Routes.RouteName    -- Group by each route
ORDER BY AverageRating DESC;                 -- Sort by the highest average rating

-- Query 4: Feedback Distribution by Day of the Week
-- Shows average ratings and feedback counts for each day of the week
SELECT 
    strftime('%w', FeedbackDate) AS DayOfWeek,  -- Extract the day of the week (0=Sunday, 1=Monday, etc.)
    CASE strftime('%w', FeedbackDate)          -- Convert day number to name
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END AS DayName,
    AVG(Rating) AS AverageRating,              -- Calculate the average rating for each day
    COUNT(FeedbackID) AS FeedbackCount         -- Count the total feedback entries for each day
FROM Feedback
GROUP BY DayOfWeek                             -- Group by each day of the week
ORDER BY DayOfWeek;                            -- Sort by the order of the days (Sunday to Saturday)

-- Query 5: Low-Rated Routes with Frequent Complaints
-- Shows routes with low ratings and a summary of common complaints for each route
SELECT 
    Routes.RouteID,                            -- Unique ID for each route
    Routes.RouteName,                          -- Name of the route
    AVG(Feedback.Rating) AS AverageRating,     -- Average rating for the route
    COUNT(Feedback.FeedbackID) AS FeedbackCount, -- Count of total feedback for the route
    GROUP_CONCAT(Feedback.Comment, '; ') AS CommonComplaints -- Combine all complaints into one string
FROM Feedback
JOIN Rides ON Feedback.RideID = Rides.RideID  -- Link feedback to rides
JOIN Routes ON Rides.RouteID = Routes.RouteID -- Link rides to routes
WHERE Feedback.Rating <= 3                    -- Focus on low ratings (3 or below)
GROUP BY Routes.RouteID, Routes.RouteName     -- Group by each route
ORDER BY AverageRating ASC, FeedbackCount DESC; -- Sort by lowest rating and most feedback