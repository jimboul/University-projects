   M S B A M L   `   `   `  ����D  @SmartCity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null%clr-namespace:SmartCity	SmartCity  5   	   *    $SmartCity.MunicipalityAdministration   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   )localclr-namespace:SmartCity     5   	     � Title$   MunicipalityAdministration��5   	   $��880.058��6,   $��1711.748��6=    � 	Resources 5	         MyButtonStyle �� 
TargetType �� Property �� Value �� 
TargetType �� Padding �� CornerRadius �� Triggers	 P� Property
 P� Value �� 
TargetName��%  &	        �� 5
   
   " ��6&   .�5      ��  �@�OverridesDefaultStyle . 66   �� 5       � ��$ 5q�6'   �� 5       � �� 5      �� 5      " ��6&   .R�5      �� $��border��6!   $��0q�5      $	 4,2q�5      
�������$ 3��5      #��z��5      ._�5      �� $��Center=�6/   $��Center=�6L   5       5      P� 5      	 �@J�IsMouseOver
 . . �5   "   �� $ border��6)    � ��
 �   �6T   5      5      5      5       5!      .��5"      � .+�5#   
   (  "System.Windows.Controls.WebBrowser  -   5          Name$ webbrowser1��5#      $
��Left=�6*   $	��685��6E   $��
30,128,0,0q�6R   $	��Top=�6f   $
��1655��6~   �� 5$   
   -   5         ��Name$ label��5$      $-��'Please choose a house to monitor below:��6   $
��Left=�6Q   $��	46,52,0,0q�6l   $	��Top=�6   $��35��6�   $	��307��6�   $��16(�6�   �� 5%   
   -   5         ��Name$
 back��5%      $�� ��6   #��[  6*    � ToolTip$ Go Back��6Q   $
��Left=�6c   $��1498,36,0,0q�6~   $	��Top=�6�   $��54��6�   $��51��6�   ��5&      �� 5'       �� ImageSource$ img/back.png��6   5)      �� 5*   
   -   5        $ button2��5*      $�� ��6"    � Cursor$
 Hand��6-   $- 'Click the door to go inside your house.��6;   $
��Left=�6m   $��1642,29,0,0q�6�   $	��Top=�6�   $��35��6�   $��33��6�   $��0q�6�   ��5+      �� 5,      $ img/help.png��6   5.      5/      50      