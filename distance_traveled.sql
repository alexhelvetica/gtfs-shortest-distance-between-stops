SELECT DISTINCT
	SUBSTRING(
		pSequence.trip_id,
	  STRPOS(
	    pSequence.trip_id,
	     '-'
	  ) + 1,
	  STRPOS(
	    SUBSTRING(
	      pSequence.trip_id,
	      STRPOS(
	 				pSequence.trip_id,
	 				'-'
	      ) + 1,
	      10
	    ),
	    '-'
	  ) - 1
	) AS route_id,
	pSequence.stop_id,
	pStop.stop_name,
	sSequence.stop_id,  
	sStop.stop_name,
	-- pSequence.stop_sequence, 
	-- sSequence.stop_sequence, 
	-- pSequence.shape_dist_traveled, 
	pSequence.shape_dist_traveled - sSequence.shape_dist_traveled AS dist_1,
	CONCAT(pStop.stop_lat, ' ', pStop.stop_lon) as pStopCoords,
	CONCAT(sStop.stop_lat, ' ', sStop.stop_lon) as sStopCoords
	-- ST_Distance(pStop.geom, b.geom) as dist_2
FROM stop_times AS pSequence

INNER JOIN stop_times AS sSequence
	ON pSequence.trip_id = sSequence.trip_id 
	AND pSequence.stop_sequence - 1 = sSequence.stop_sequence

INNER JOIN stops AS pStop
	ON pSequence.stop_id = pStop.stop_id

INNER JOIN stops AS sStop
 ON sSequence.stop_id = sStop.stop_id
ORDER BY dist_1;

