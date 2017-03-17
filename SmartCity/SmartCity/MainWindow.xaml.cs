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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace SmartCity
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            //label.Foreground = new SolidColorBrush(Colors.Red);
        }
    
        // Common user's credentials 
        string username = "jimbo";
        string password = "1";
        // Municipality user's credentials
        string username1 = "babis";
        string password1 = "2";
        // Age grouper's credentials
        string username2 = "frosw";
        string password2 = "3";

        private void exit_Click(object sender, RoutedEventArgs e)
        {
            App.Current.Shutdown();
        }

        private void signin_Click(object sender, RoutedEventArgs e)
        {
            if (user.Text == username && pass.Password == password)
            {
                MessageBoxResult msg = MessageBox.Show("Logged in as a consumer");
                if (msg == MessageBoxResult.OK)
                {
                    this.Hide();
                    Citizen citizen = new Citizen();
                    citizen.Show();
                }
            }
            if (user.Text == username1 && pass.Password == password1)
            {
                MessageBoxResult msg = MessageBox.Show("Logged in as an employee of Municipality");
                if (msg == MessageBoxResult.OK)
                {
                    this.Hide();
                    MunicipalityAdministration municipalityAdministration = new MunicipalityAdministration();
                    municipalityAdministration.Show();
                }
            }
            if (user.Text == username2 && pass.Password == password2)
            {
                MessageBoxResult msg = MessageBox.Show("Logged in as an age grouper");
                if (msg == MessageBoxResult.OK)
                {
                    this.Hide();
                    AgeGroup agegroup = new AgeGroup();
                    agegroup.Show();
                }
            }
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(button.ToolTip.ToString());
        }
    }
}
