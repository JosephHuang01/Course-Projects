SELECT 
	Routes.RouteID, 
    Routes.StartLocation, 
    Routes.EndLocation, 
    SUM(Rides.TicketPrice) AS total_revenue
FROM 
    Routes
JOIN 
    Rides ON Routes.RouteID = Rides.RouteID
GROUP BY 
    Routes.RouteID, Routes.StartLocation, Routes.EndLocation
ORDER BY 
    total_revenue DESC;
