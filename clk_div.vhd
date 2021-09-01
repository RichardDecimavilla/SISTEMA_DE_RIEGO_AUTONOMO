library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
  
entity clk_div is
	generic(
		cycle_cnt		: integer := 10;
		init_tmp			: std_logic:= '0'
	);
	
	port (
		clk,reset		: in std_logic;									
		clk_out		: out std_logic							
		
	);
end clk_div;
  
architecture bhv of clk_div is

signal cnt: integer range 0 to cycle_cnt := 0;			
signal tmp 	: std_logic := init_tmp;									
  
begin
  
	conteno_inversion: process(clk,reset,tmp)
	begin
		if(reset='1') then
			cnt<=0;
			tmp<=init_tmp;
		elsif(clk'event and clk='1') then
			cnt <=cnt+1;
				if (cnt = cycle_cnt) then		
					tmp <= NOT tmp;					
					cnt <= 1;							
				end if;
		end if;
		clk_out <= tmp;
	end process;
  
end bhv;
