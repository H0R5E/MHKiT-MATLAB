classdef Fail_Test < matlab.unittest.TestCase

    methods (Test)

        function example_fail(testCase)
            testCase.verifyFail("An example failure.")
        end

    end
    
end
