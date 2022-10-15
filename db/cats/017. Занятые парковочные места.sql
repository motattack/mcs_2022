SELECT CarNumber,
	   ParkingNumber
FROM Cars as c,
	 CarsParkings as cp,
	 ParkingPlaces as pp
WHERE pp.ID = cp.ParkingID AND c.ID = cp.CarID;
