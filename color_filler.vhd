----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2024 04:26:42 PM
-- Design Name: 
-- Module Name: color_filler - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity color_filler is
    generic (
        bus_width : integer := 6;
        sel_width : integer := 6
    );
    Port ( clk, en,vid :in std_logic;
         hcount,vcount:in std_logic_vector(9 downto 0);
         Rout,Bout: out std_logic_vector(4 downto 0);
         Gout: out std_logic_vector( 5 downto 0);
         grid : in std_logic_vector((sel_width * bus_width) - 1 downto 0)
        );
end color_filler;

architecture Behavioral of color_filler is

    signal idx : integer:=0;
    signal hcounter,vcounter: std_logic_vector(9 downto 0):= (others => '0');
begin

    grid_counter: process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' and vid = '1' then
                if (unsigned(hcounter) <= 599) and (unsigned(vcounter) <= 479) then
                    if (unsigned(hcounter) mod 100 = 0) then
                        idx <= idx+1;
                    end if;
                end if;

                if(idx = 7) then
                    Rout<= "11111";
                    Gout <= "000000";
                    Bout <= "00000";
                else
                    Rout<= "00000";
                    Gout <= "000000";
                    Bout <= "11111";
                end if;

            end if;
        end if;
    end process;

    hcounter <= hcount;
    vcounter <= vcount;
end Behavioral;
