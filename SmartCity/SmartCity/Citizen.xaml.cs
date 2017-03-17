using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace SmartCity
{
    /// <summary>
    /// Interaction logic for Citizen.xaml
    /// </summary>
    public partial class Citizen : Window
    {
        public Citizen()
        {
            InitializeComponent();
        }

        private void enter(object sender, RoutedEventArgs e)
        {
            SmartHome sh = new SmartHome();
            this.Hide();
            sh.Show();
        }

        private void calendar(object sender, RoutedEventArgs e)
        {
            // Smart Plan
            this.Hide();
            SmartPlan smartplan = new SmartPlan();
            smartplan.Show();
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(button2.ToolTip.ToString());
        }

        private void back_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainwindow = new MainWindow();
            mainwindow.Show();
            this.Hide();
            MessageBox.Show("You are logged out!");
        }
    }
}
