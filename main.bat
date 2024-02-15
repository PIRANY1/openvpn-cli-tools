rem Checks if the 
@if not defined debug_assist (@ECHO OFF) else (@echo on)
if not defined devtools (goto nodev) else (goto dtd)
:nodev

