   M S B A M L   `   `   `  ����D  @SmartCity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null%clr-namespace:SmartCity	SmartCity  5   	       SmartCity.Citizen   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   )localclr-namespace:SmartCity     5   	     � Title$  Citizen��5   	   $��295.3��6   $��512.272��6(    � WindowStartupLocation$ CenterScreen=�68    � 	Resources 5	         MyButtonStyle �� 
TargetType �� Property �� Value �� 
TargetType �� Padding �� CornerRadius	 �� Triggers
 P� Property P� Value �� 
TargetName��%  &	        �� 5
   
   " ��6&   .�5      ��  �@�OverridesDefaultStyle . 66   �� 5       � ��$ 5q�6'   �� 5       � �� 5      �� 5      " ��6&   .R�5      �� $��border��6!   $��0q�5      $	 4,2q�5      
�������$ 3��5      #��z��5      ._�5      �� $��Center=�6/   $��Center=�6L   5      	 5      P� 5      
 �@J�IsMouseOver . . �5   "   �� $ border��6)    � ��
 �   �6T   5      5      5      5       5!      .��5"      � .+�5#   
   �� -   5         ��Name$ image1��5#      $
��Left=�6    $	��100��6;   $��
106,84,0,0q�6H   $	��Top=�6\   $	��100��6t   $��img/House-icon.png��6�    J� OpacityMask 5$      �� 5%       �� ImageSource$ img/House-icon.png��6   5'      �� 5(   
   -   5        $ image2��5(      $��Center=�6    $	��100��6\   $��307,84,97,0q�6i   $	��Top=�6~   $	��100��6�    � ToolTip$ Enter your Smart Plan��6�   $��img/calendar.png��6�    5)      �� 5*      $ img/calendar.png��6   5,      �� 5-   
   -   5         ��Name$ button2��5-      $�� ��6"    � Cursor$
 Hand��6-   $k eClick the Home button to enter your smart home or click the Calendar button to enter your smart plan.��6;   $
��Left=�6�   $��
461,10,0,0q�6�   $	��Top=�6�   $��33��6�   $��32��6�   $��0q�6	  $��1��6  ��5.      �� 5/      $ img/help.png��6   51      �� 52   
   -   5         ��Name$ label��52      $��Welcome Citizen!��6   $
��Left=�6:   $��	10,10,0,0q�6U   $	��Top=�6h   $	��148��6�   $��41��6�   $��16(�6�   $��Comic Sans MS)�6�   �� 53   
   -   5        $
 back��53      $�� ��6   #��[  6*   $ Go Back��6Q   $
��Left=�6c   $��436,203,0,0q�6~   $	��Top=�6�   $��37��6�   $��43��6�   ��54      �� 55      $ img/back.png��6   57      58      59      