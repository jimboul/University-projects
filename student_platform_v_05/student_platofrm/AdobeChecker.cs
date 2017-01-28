using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Win32;
using System.Windows.Forms;

namespace student_platofrm
{
    class AdobeChecker
    {
        public void checkExistence()
        {
            RegistryKey software = Registry.LocalMachine.OpenSubKey("Software");

            if (software != null)
            {
                RegistryKey adobe=null;

                // Try to get 64bit versions of adobe
                if (Environment.Is64BitOperatingSystem)
                {
                    RegistryKey software64 = software.OpenSubKey("Wow6432Node");

                    if (software64 != null)
                        adobe = software64.OpenSubKey("Adobe");
                }

                // If a 64bit version is not installed, try to get a 32bit version
                if (adobe == null)
                    adobe = software.OpenSubKey("Adobe");

                // If no 64bit or 32bit version can be found, chances are adobe reader is not installed.
                if (adobe != null)
                {
                    RegistryKey acroRead = adobe.OpenSubKey("Acrobat Reader");

                    if (acroRead != null)
                    {
                        string[] acroReadVersions = acroRead.GetSubKeyNames();
                        //MessageBox.Show("The following version(s) of Acrobat Reader are installed: ");

                        foreach (string versionNumber in acroReadVersions)
                        {
                           // MessageBox.Show(versionNumber);
                        }
                    }
                    else
                        if (MessageBox.Show("Adobe reader is not installed! This program requires Adobe reader installed on local compute rin order to run properly."
                            + "Please press OK to download the last version of adobe reader.", "Caution!") == DialogResult.OK)
                        {
                            System.Diagnostics.Process.Start("https://get.adobe.com/reader/");
                            if (MessageBox.Show("Please click ok when the installation of Adobe reader has finished.") == DialogResult.OK)
                                checkExistence();
                        }
                }
                else
                    if (MessageBox.Show("Adobe reader is not installed! This program requires Adobe reader installed on local compute rin order to run properly."
                            + "Please press OK to download the last version of adobe reader.", "Caution!") == DialogResult.OK)
                    {
                        System.Diagnostics.Process.Start("https://get.adobe.com/reader/");
                        if (MessageBox.Show("Please click ok when the installation of Adobe reader has finished.") == DialogResult.OK)
                            checkExistence();
                    }

            }
        }
    }
}
