package com.unipi.alexnikas.matheducation;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.ImageView;

public class Statistics extends AppCompatActivity {
    private ImageView imageView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_statistics);
        imageView = (ImageView) findViewById(R.id.imageView);
        imageView.setImageResource(R.mipmap.stats);
    }
}
