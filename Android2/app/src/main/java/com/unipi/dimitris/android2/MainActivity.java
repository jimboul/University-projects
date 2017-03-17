package com.unipi.dimitris.android2;

import android.content.Intent;
import android.content.pm.PackageManager;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

public class MainActivity extends AppCompatActivity {
    EditText editText, editText2, editText3, editText4;
    double latitude, longitude;
    int radius;
    String name, values;
    Intent intent;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        if(ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED){
            ActivityCompat.requestPermissions(this, new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION},9);
        }
        editText = (EditText)findViewById(R.id.editText);
        editText2 = (EditText)findViewById(R.id.editText2);
        editText3 = (EditText)findViewById(R.id.editText3);
        editText4 = (EditText)findViewById(R.id.editText4);
        intent = new Intent(this, Main2Activity.class);

    }
    public void submit(View view) {
        latitude = Double.parseDouble(editText.getText().toString());
        longitude = Double.parseDouble(editText2.getText().toString());
        radius = Integer.parseInt(editText3.getText().toString());
        name = editText4.getText().toString();
        values = latitude + "; " + longitude + "; " + radius;
        editText.setText("");
        editText2.setText("");
        editText3.setText("");
        editText4.setText("");
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference referenceCoordinates = database.getReference("location");
        referenceCoordinates.child(name).setValue(values);
        Toast.makeText(getApplicationContext(), "Success", Toast.LENGTH_LONG).show();
    }

    public void go(View view) {
        startActivity(intent);
    }
}