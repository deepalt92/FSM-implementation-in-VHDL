ENTITY pppFSM is
PORT (clock:    IN STD_LOGIC;
      P:        IN STD_LOGIC_VECTOR(4 downto 0);
      reset:    IN STD_LOGIC;
      );
END pppFSM;


-- Architecture definition for the SimpleFSM entity
Architecture RTL of SimpleFSM is
TYPE State_type IS (Initial, Starting,Closed,Closing,Stopped,Stopping,Req_sent,Opened,Ack_sent,Ack_rcvd);  -- Define the states
	SIGNAL State : State_Type;    -- Create a signal that 
BEGIN 
  PROCESS (clock, reset) 
  BEGIN 
    If (reset = ‘1’) THEN    
	State <= Initial;
 
    ELSIF rising_edge(clock) THEN    -- if there is a rising edge 
			 -- clock, then do the stuff below
 
	-- The CASE statement checks the value of the State    
	-- and based on the value and any other control signals, --change s to a new state.

	CASE State IS
 
		
		WHEN Initial => 
			IF P='00000' THEN 
				State <= Closed;
			ELSE IF P='00010' THEN
				State<=Starting
			ELSE IF P='00011' THEN
				State<=Initial 
			END IF; 
 
	
		
		WHEN Starting => 
			IF P='00000' THEN 
				State <= Req_sent;
			ELSE IF P='00010' THEN
				State<=Starting;
			END IF; 
 
		WHEN Closed => 
			IF P='0010' THEN 
				State <= Req_sent;
			ELSE IF P='00001' THEN
				State<=Initial;
			ELSE IF P='00100' THEN
				State<=Closed 
			END IF; 
 
		
		WHEN Stopped=> 
			IF P='00110' THEN 
				State <= Stopped; 
			ELSE IF P='00011' THEN
				State <=Closed ; 
			ELSE IF P='00001' THEN
				State<=Starting;
			ELSE IF P='01101' THEN
				State<=Req_sent;
			ELSE IF P='01100' THEN			
				State<=Ack_sent
			END IF; 
		WHEN Closing =>
			IF P='00101' THEN
				State <= Closing;
			ELSE IF P='00001' THEN
				State<=Initial;
			ELSE IF P='01110' THEN
				State<=Closed;
			ELSE IF P='00010' THEN
				State<=Stopping;
			END IF;
		WHEN Req_sent=>
			IF P='01001' THEN
				State<=Req_sent;
			ELSE IF P='01101' THEN
				State<=Opened;
			ELSE IF P='01100' THEN
				State<=Ack_sent;
			ELSE IF P='10000' THEN
				State<=Ack_rcvd;
			ELSE IF P='10011' THEN
				State<=Stopped;
			ELSE IF P='00001' THEN
				State<=Starting;
			ELSE IF P='00011' THEN
				State<=Closing;
			END IF;
		WHEN Stopping=>
			IF P='00111' THEN
				State<=Stopping;
			ELSE IF	P='00011' THEN
				State<=Closing;
			ELSE IF P='01110' THEN
				State<=Stopped;
			ELSE IF P='00001' THEN
				State<=Starting;
			END IF;
		WHEN Opened=>
			IF P='01000' THEN
				State<=Opened;
			ELSE IF P='00001' THEN
				State<=Starting;
			ELSE IF P='00011' THEN
				State<=Closing;
			ELSE IF P='01111' THEN
				State<=Stopping;
			ELSE IF P='01100' THEN
				State<=Ack_sent;
			END IF;
		WHEN Ack_sent=>
			IF P='01010' THEN
				State<=Ack_sent;
			ELSE IF P='00011' THEN
				State<=Closing;
			ELSE IF P='10000' THEN
				State<=Opened;
			ELSE IF P='10010' THEN
				State<=Red_sent;
			ELSE IF P='00001' THEN
				State<=Starting;
			ELSE IF P='10011' THEN
				State<=Stopped;
			END IF;
		WHEN Ack_rcvd=>
			IF P='01011' THEN
				State<=Ack_rcvd;
			ELSE IF P='10000' THEN
				State<=Opened;
			ELSE IF P='00011' THEN
				State<=Closing;
			ELSE IF P='10001' THEN
				State<=Req_sent;
			ELSE IF P='10011' THEN
				State<=Stopped;
			ELSE IF P='00001' THEN
				State<=Starting;
			END IF;

			
	END CASE; 
    END IF; 
  END PROCESS;

END RTL;
