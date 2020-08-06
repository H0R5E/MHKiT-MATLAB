classdef River_TestIO < matlab.unittest.TestCase

    methods (Test) 

        function test_load_usgs_data_instantaneous(testCase)            
            file_name = 'data/USGS_08313000_Jan2019_instantaneous.json';
            data = read_usgs_file(file_name);

            assertEqual(testCase,data.units, struct('Discharge', " cubic feet per second"));
            assertEqual(testCase,size(data.Discharge), [2972 1]); % 4 data points are missing
        end

        function test_load_usgs_data_daily(testCase)
            file_name = 'data/USGS_08313000_Jan2019_daily.json';
            data = read_usgs_file(file_name);
            
            expected_index = datestr(datetime(2019,01,01):datetime(2019,01,31));
            data.time = datestr(data.time/86400 + datenum(1970,1,1));
            
            assertEqual(testCase,data.units, struct('Discharge', " cubic feet per second"));
            assertEqual(testCase,data.time, expected_index);
            assertEqual(testCase,size(data.Discharge), [31 1]); % 4 data points are missing
        end

        function test_request_usgs_data_daily(testCase)
            data=request_usgs_data("15515500","00060","2009-08-01","2009-08-10","data_type",'Daily');
            
            assertEqual(testCase,data.units, struct('Discharge', " cubic feet per second"));
            assertEqual(testCase,size(data.Discharge), [10 1]);
        end

        function test_request_usgs_data_instant(testCase)
            data=request_usgs_data("15515500","00060","2009-08-01","2009-08-10","data_type",'Instantaneous');
            
            assertEqual(testCase,data.units, struct('Discharge'," cubic feet per second"));
            assertEqual(testCase,size(data.Discharge), [10*24*4 1]);
        end
    end
end