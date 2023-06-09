-- Database: projeto-informatico_dw

CREATE TABLE t_dim_road_event
(
	road_event_key INT PRIMARY KEY,
	description VARCHAR(100) NOT NULL,
	severity VARCHAR(10) NOT NULL,
	status VARCHAR(10) NOT NULL,
	impact_level VARCHAR(11) NOT NULL
);

CREATE TABLE t_dim_road_sign
(
	road_sign_key VARCHAR(10) PRIMARY KEY,
	road_sign_description VARCHAR(50) NOT NULL,
	road_sign_code VARCHAR(10) NOT NULL,
	road_sign_symbol BYTEA NOT NULL,
	road_sign_class VARCHAR(20) NOT NULL,
	road_sign_visibility VARCHAR(20) NOT NULL
);

CREATE TABLE t_dim_event
(
	event_key INT PRIMARY KEY,
	designation VARCHAR(100) NOT NULL,
	start_time FLOAT NOT NULL,
	end_time FLOAT NOT NULL,
	flag_single_day_event BOOLEAN NOT NULL
);

CREATE TABLE t_dim_zone
(
	zone_key INT PRIMARY KEY,
	zone_name VARCHAR(100) NOT NULL,
	zone_type VARCHAR(20) NOT NULL,
	zone_description VARCHAR(20) NOT NULL,
	zone_area VARCHAR(20) NOT NULL
);

CREATE TABLE t_dim_road
(
	road_key INT PRIMARY KEY,
	road_name VARCHAR(20) NOT NULL,
	road_type VARCHAR(20) NOT NULL,
	road_length INT NOT NULL,
	number_of_lanes INT NOT NULL,
	start_point FLOAT NOT NULL,
	end_point FLOAT NOT NULL
);

CREATE TABLE t_dim_segment
(
	segment_key INT PRIMARY KEY,
	road_key INT NOT NULL,
	segment_name VARCHAR(20) NOT NULL,
	segment_type VARCHAR(20) NOT NULL,
	segment_length INT NOT NULL,
	number_of_lanes INT NOT NULL,
	start_point FLOAT NOT NULL,
	end_point FLOAT NOT NULL,
	FOREIGN KEY (road_key) REFERENCES t_dim_road (road_key)
);

CREATE TABLE t_dim_time
(
	time_key INT PRIMARY KEY,
	event_key INT NOT NULL,
	c_day INT NOT NULL,
	c_month INT NOT NULL,
	c_year INT NOT NULL,
	weekend_day BOOLEAN NOT NULL,
	week_day_number INT NOT NULL,
	week_day_name VARCHAR(10) NOT NULL,
	is_holiday BOOLEAN NOT NULL,
	trimester INT NOT NULL,
	semester INT NOT NULL,
	season VARCHAR(20) NOT NULL,
	full_date_description VARCHAR(20) NOT NULL,
	FOREIGN KEY (event_key) REFERENCES t_dim_event (event_key)
);

CREATE TABLE t_fact_cam
(
	cam_key INT PRIMARY KEY,
	time_key INT NOT NULL,
	segment_key INT NOT NULL,
	station_id INT NOT NULL,
	latitude INT NOT NULL,
	longitude INT NOT NULL,
	altitude INT NOT NULL,
	speed INT NOT NULL,
	heading INT NOT NULL,
	acceleration INT NOT NULL,
	station_type VARCHAR(20) NOT NULL,
	vehicle_role VARCHAR(20) NOT NULL,
	time_stamp INT NOT NULL,
	fuel_type VARCHAR(20) NOT NULL,
	brake_pedal_engaged BOOLEAN NOT NULL,
	gas_pedal_engaged BOOLEAN NOT NULL,
	emergency_pedal_engaged BOOLEAN NOT NULL,
	collision_warning_engaged BOOLEAN NOT NULL,
	acc_engaged BOOLEAN NOT NULL,
	cruise_control_engaged BOOLEAN NOT NULL,
	speed_limiter_engaged BOOLEAN NOT NULL,
	stationary_since VARCHAR(20) NULL,
	FOREIGN KEY (time_key) REFERENCES t_dim_time (time_key),
	FOREIGN KEY (segment_key) REFERENCES t_dim_segment (segment_key)
); 

CREATE TABLE t_fact_denm
(
	denm_key INT PRIMARY KEY,
	time_key INT NOT NULL,
	road_event_key INT NOT NULL,
	time_stamp INT NOT NULL,
	latitude INT NOT NULL,
	longitude INT NOT NULL,
	altitude INT NOT NULL,
	heading INT NOT NULL,
	cause VARCHAR(50) NOT NULL,
	sub_cause VARCHAR(50) NULL,
	traffic_cause VARCHAR(50) NULL,
	accident_sub_cause_code VARCHAR(50) NULL,
	road_works_sub_cause VARCHAR(50) NULL,
	accident_sub_cause VARCHAR(50) NULL,
	slow_vehicle_sub_cause VARCHAR(50) NULL,
	stationary_vehicle_cause VARCHAR(50) NULL,
	human_problem_sub_cause VARCHAR(50) NULL,
	collision_risk_sub_cause VARCHAR(50) NULL,
	dangerous_situation_sub_cause VARCHAR(50) NULL,
	vehicle_break_down_sub_cause VARCHAR(50) NULL,
	post_crash_sub_cause VARCHAR(50) NULL,
	human_presence_on_the_road_sub_cause VARCHAR(50) NULL,
	adverse_weather_condition_extreme_weather_condition_sub_cause VARCHAR(50) NULL,
	adverse_weather_condition_adhesion_sub_cause VARCHAR(50) NULL,
	adverse_weather_condition_visibility_sub_cause VARCHAR(50) NULL,
	adverse_weather_condition_precipitation_sub_cause VARCHAR(50) NULL,
	emergency_vehicle_approaching_sub_cause VARCHAR(50) NULL,
	hazardous_location_surface_condition_sub_cause VARCHAR(50) NULL,
	hazardous_location_obstacle_on_the_road_sub_cause VARCHAR(50) NULL,
	hazardous_location_animal_on_the_road_sub_cause VARCHAR(50) NULL,
	rescue_and_recovery_work_in_progress_sub_cause VARCHAR(50) NULL,
	dangerous_end_of_queue_sub_cause VARCHAR(50) NULL,
	FOREIGN KEY (time_key) REFERENCES t_dim_time (time_key),
	FOREIGN KEY (road_event_key) REFERENCES t_dim_road_event (road_event_key)
);

CREATE TABLE t_fact_ivim
(
	ivim_key INT PRIMARY KEY,
	road_sign_key VARCHAR(10) NOT NULL,
	zone_key INT NOT NULL,
	latitude INT NOT NULL,
	longitude INT NOT NULL,
	altitude INT NOT NULL,
	FOREIGN KEY (road_sign_key) REFERENCES t_dim_road_sign (road_sign_key),
	FOREIGN KEY (zone_key) REFERENCES t_dim_zone (zone_key)
);
