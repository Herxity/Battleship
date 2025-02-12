----------------------------------------------------------------------------------
-- Company: Digilent Inc 2011
-- Engineer: Michelle Yu  
-- Create Date:    17:05:39 08/23/2011 
--
-- Module Name:    PmodKYPD - Behavioral 
-- Project Name:  PmodKYPD
-- Target Devices: Nexys3
-- Tool versions: Xilinx ISE 13.2 
-- Description: 
--	This file defines a project that outputs the key pressed on the PmodKYPD to the seven segment display
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keypad is
    Port (
        clk : in  STD_LOGIC;
        JA : inout  STD_LOGIC_VECTOR (7 downto 0);
         led: out std_logic_vector(3 downto 0)
    ); -- PmodKYPD is designed to be connected to JA
end keypad;

architecture Behavioral of keypad is

    component Decoder is
        Port (
            clk : in  STD_LOGIC;
            Row : in  STD_LOGIC_VECTOR (3 downto 0);
            Col : out  STD_LOGIC_VECTOR (3 downto 0);
            DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;



    signal Decode: STD_LOGIC_VECTOR (3 downto 0);
begin


    C0:Decoder
        port map(
            clk => clk,
            Row =>JA(7 downto 4),
            Col=>JA(3 downto 0),
            DecodeOut=> led
        );



end Behavioral;

