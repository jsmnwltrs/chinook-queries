

--1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
select  c.CustomerId, c.FirstName, c.LastName, c.Country
from dbo.Customer c

--2. `brazil_customers.sql`: Provide a query only showing the Customers from Brazil.
select c.CustomerId, c.FirstName, c.LastName, c.Country
from dbo.Customer c
where c.Country = 'Brazil'

--3. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
select c.FirstName, c.LastName, i.InvoiceId, i.InvoiceDate, i.BillingCountry
from dbo.Customer c
join dbo.Invoice i on c.CustomerId = i.CustomerId
where c.Country = 'Brazil'

--4. Provide a query showing only the Employees who are Sales Agents.
select e.*
from dbo.Employee e
where e.Title = 'Sales Support Agent'

--5. Provide a query showing a unique/distinct list of billing countries from the Invoice table.
select distinct i.BillingCountry
from dbo.Invoice i

--6. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
select e.FirstName, e.LastName, e.Title, i.InvoiceId, c.CustomerId
from dbo.Employee e
join dbo.Customer c on e.EmployeeId = c.SupportRepId
join dbo.Invoice i on c.CustomerId = i.CustomerId
where e.Title = 'Sales Support Agent'

--7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
select i.InvoiceId, InvoiceTotal = i.Total, i.BillingCountry, CustomerName = c.FirstName + ' ' + c.LastName, SalesAgentName = e.FirstName + ' ' + e.LastName
from dbo.Employee e
join dbo.Customer c on e.EmployeeId = c.SupportRepId
join dbo.Invoice i on c.CustomerId = i.CustomerId

--8. How many Invoices were there in 2009 and 2011?
select totalInvoices = count(*)
from dbo.Invoice i
where i.InvoiceDate between '2009-01-01 00:00:00.000' and '2011-12-31 00:00:00.000'

--9. What are the respective total sales for each of those years?
select TotalInvoiceSum = Sum(i.Total)
from dbo.Invoice i
where i.InvoiceDate between '2009-01-01 00:00:00.000' and '2011-12-31 00:00:00.000'

--10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
select TotalInvoiceLineCount = count(*)
from dbo.InvoiceLine il
where il.InvoiceId = 37

--11. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql)
select il.InvoiceId, TotalInvoiceLineCount = count(*)
from dbo.InvoiceLine il
group by il.InvoiceId

--12. Provide a query that includes the purchased track name with each invoice line item.
select il.InvoiceLineId, t.Name
from dbo.InvoiceLine il
join dbo.Track t on il.TrackId = t.TrackId

--13. Provide a query that includes the purchased track name AND artist name with each invoice line item.
select t.Name, a.Name
from dbo.Track t
join dbo.Album ab on t.AlbumId = ab.AlbumId
join dbo.Artist a on ab.ArtistId = a.ArtistId

--14. Provide a query that shows the # of invoices per country. HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql)
select i.BillingCountry, numberOfInvoices = count(*) 
from dbo.Invoice i
group by i.BillingCountry

--15. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.
select p.Name, numberOfTracks = count(*)
from dbo.Playlist p
join dbo.PlaylistTrack pt on p.PlaylistId = pt.PlaylistId
group by p.Name

--16. Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
select Track = t.Name, MediaType = m.Name, Genre = g.Name
from dbo.Track t
join dbo.MediaType m on t.MediaTypeId = m.MediaTypeId
join dbo.Genre g on t.GenreId = g.GenreId 

--17. Provide a query that shows all Invoices but includes the # of invoice line items.
select i.InvoiceId, TotalInvoiceLineCount = count(*)
from dbo.Invoice i
join dbo.InvoiceLine il on i.InvoiceId = il.InvoiceId
group by i.InvoiceId

--18. Provide a query that shows total sales made by each sales agent.
select EmployeeName = e.FirstName + ' ' + e.LastName, e.Title, TotalSales = count(*)
from dbo.Employee e
join dbo.Customer c on e.EmployeeId = c.SupportRepId
join dbo.Invoice i on c.CustomerId = i.CustomerId
where e.Title = 'Sales Support Agent'
group by e.FirstName, e.LastName, e.Title

--19. Which sales agent made the most in sales in 2009? HINT: [MAX](https://docs.microsoft.com/en-us/sql/t-sql/functions/max-transact-sql)
select Top(1) EmployeeName = e.FirstName + ' ' + e.LastName, e.Title, TotalSalesCost = Sum(i.Total)
from dbo.Employee e
join dbo.Customer c on e.EmployeeId = c.SupportRepId
join dbo.Invoice i on c.CustomerId = i.CustomerId
where e.Title = 'Sales Support Agent' and Year(i.InvoiceDate) = 2009
group by e.FirstName, e.LastName, e.Title
order by TotalSalesCost desc

--20. Which sales agent made the most in sales over all?
select TOP(1) EmployeeName = e.FirstName + ' ' + e.LastName, e.Title, TotalSalesCost = Sum(i.Total)
from dbo.Employee e
join dbo.Customer c on e.EmployeeId = c.SupportRepId
join dbo.Invoice i on c.CustomerId = i.CustomerId
where e.Title = 'Sales Support Agent'
group by e.FirstName, e.LastName, e.Title
order by TotalSalesCost desc

--21. Provide a query that shows the count of customers assigned to each sales agent.
select EmployeeName = e.FirstName + ' ' + e.LastName, e.Title, TotalCustomers = count(*)
from dbo.Employee e
join dbo.Customer c on e.EmployeeId = c.SupportRepId
where e.Title = 'Sales Support Agent'
group by e.FirstName, e.LastName, e.Title

--22. Provide a query that shows the total sales per country.
select i.BillingCountry, TotalSales = count(*)
from dbo.Invoice i
group by i.BillingCountry

--23. Which country's customers spent the most?
select Top(1) i.BillingCountry, TotalSalesCost = Sum(i.Total)
from dbo.Invoice i
group by i.BillingCountry
order by TotalSalesCost desc

--24. Provide a query that shows the most purchased track of 2013.
declare @invoiceYear int = 2013

select t.Name, Total = count(*)
from dbo.Track t
join dbo.InvoiceLine il on t.TrackId = il.TrackId
join dbo.Invoice i on i.InvoiceId = il.InvoiceId
where Year(i.InvoiceDate) = @invoiceYear
group by t.TrackId, t.Name
order by t.Name

--25. `top_5_tracks.sql`: Provide a query that shows the top 5 most purchased songs.
select TOP(5) t.Name, Total = count(*)
from dbo.Track t
join dbo.InvoiceLine il on t.TrackId = il.TrackId
group by t.TrackId, t.Name
order by Total desc

--26. `top_3_artists.sql`: Provide a query that shows the top 3 best selling artists.
select TOP(3) a.Name, Total = count(*)
from dbo.Artist a
join dbo.Album ab on ab.ArtistId = a.ArtistId 
join dbo.Track t on t.AlbumId = ab.AlbumId
join dbo.InvoiceLine il on t.TrackId = il.TrackId
group by a.ArtistId, a.Name
order by Total desc

--27. `top_media_type.sql`: Provide a query that shows the most purchased Media Type.
select TOP(1) mt.Name, Total = count(*)
from dbo.MediaType mt
join dbo.Track t on t.MediaTypeId = mt.MediaTypeId
join dbo.InvoiceLine il on t.TrackId = il.TrackId
group by mt.MediaTypeId, mt.Name
order by Total desc