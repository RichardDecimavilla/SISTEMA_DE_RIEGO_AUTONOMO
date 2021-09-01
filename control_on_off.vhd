library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_on_off is
    Port ( 

			  hora_real		: in	std_logic_vector(4 downto 0);
			  minuto_real	: in	std_logic_vector(5 downto 0);

			  hora_prog		: in  std_logic_vector(4 downto 0);
			  min_prog		: in std_logic_vector(5 downto 0);

			  dur_riego		: in std_logic_vector(5 downto 0);
			  -- v_outs
           v_out	: out std_logic
	 );
end control_on_off;

architecture logic of control_on_off is

signal hora_minutos_real	: std_logic_vector(10 downto 0):= "00000000000";
signal hora_minutos_prog	: std_logic_Vector(10 downto 0):= "00000000000";
signal hora_minutos_finl	: std_logic_Vector(10 downto 0):= "00000000000";
begin

	hora_minutos_real(5 downto 0)		<= minuto_real;
	hora_minutos_real(10 downto 6)	<= hora_real;
	
	hora_minutos_prog(5 downto 0) 	<= min_prog;
	hora_minutos_prog(10 downto 6) 	<= hora_prog;

	hora_minutos_finl <= hora_minutos_prog + dur_riego;
	
	process(hora_minutos_real,hora_minutos_prog,hora_minutos_finl)	
		begin
		if ((hora_minutos_real>=hora_minutos_prog) and (hora_minutos_real<hora_minutos_finl)) then 
			v_out <= '1';
		else
			v_out <= '0';
		end if;
	end process;
end logic;