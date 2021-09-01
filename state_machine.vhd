library ieee;
use ieee.std_logic_1164.all;

entity state_machine is

	port(
		clk		 		: in	std_logic;							
		start	 			: in	std_logic;							
		reset	 			: in	std_logic;							
		conf_done		: in  std_logic; -- temporizador detecta la inactivadad del usuario						
		conf_tmp_riego	: out std_logic;							 
		estados	 		: out	std_logic_vector(2 downto 0)	
	);
	
end entity;

architecture logic of state_machine is

	
	type state_type is (s0, s1, s2, s3, s4, s5);
	
	
	signal state   : state_type;

begin
	
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if start = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					if start = '0' then
						state <= s2;
					else
						state <= s1;
					end if;
				when s2=>
					if conf_done = '1' then
						state <= s3;
					else
						state <= s2;
					end if;
				when s3 =>
					if conf_done = '0' then
						state <= s4;
					else
						state <= s3;
					end if;
				when s4 =>
					if conf_done = '1' then
						state <= s5;
					else
						state <= s4;
					end if;
				when s5 =>
					if conf_done = '0' then
						state <= s0;
					else
						state <= s5;
					end if;
			end case;
		end if;
	end process;
	
	process (state)
	begin
	
		case state is
			when s0 =>
				conf_tmp_riego <= '0';
				estados 			<= "000";
			when s1 =>
				conf_tmp_riego <= '0';
				estados			<= "001";
			when s2 =>
				conf_tmp_riego <= '0';
				estados 			<= "010";
			when s3 =>
				conf_tmp_riego <= '0';
				estados 			<= "011";
			when s4 =>
				conf_tmp_riego <= '1';
				estados 			<= "100";
			when s5 =>
				conf_tmp_riego <= '0';
				estados 			<= "101";
		end case;
	end process;
	
end logic;