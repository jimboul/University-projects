package com.unipi.alexnikas.matheducation;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.design.widget.NavigationView;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;



public class Welcome extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener, WallFragment.OnFragmentInteractionListener, Profile.OnFragmentInteractionListener, NewPost.OnFragmentInteractionListener, Search.OnFragmentInteractionListener, SearchResult.OnFragmentInteractionListener, ChapterView.OnFragmentInteractionListener, ChapterSelect.OnFragmentInteractionListener, TestSelect.OnFragmentInteractionListener, TestView.OnFragmentInteractionListener, Badges.OnFragmentInteractionListener{

    Intent intent2;
    String username;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        intent2 = new Intent(this, Profile.class);
        username = getIntent().getExtras().getString("username");
        //FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
//        fab.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
//                        .setAction("Action", null).show();
//            }
//        });

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

    }

    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.profile, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.new_post) {

            NewPost newPost = new NewPost();
            FragmentManager fragmentManager = getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.fragment_container, newPost);
            fragmentTransaction.addToBackStack(null);
            fragmentTransaction.commit();
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.user_profile) {

            Profile fragment = new Profile();
            Bundle bundle = new Bundle();
            bundle.putString(username,"username");
            fragment.setArguments(bundle);
            intent2 = getIntent().putExtras(bundle);
//            startActivity(intent2);

            Profile profile = new Profile();
            FragmentManager fragmentManager = getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.fragment_container, profile);
            fragmentTransaction.commit();

        } else if (id == R.id.search) {

            Search search = new Search();
            FragmentManager fragmentManager = getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.fragment_container, search);
            fragmentTransaction.commit();

        } else if (id == R.id.chapters) {
            ChapterSelect fragment = new ChapterSelect();
            Bundle bundle = new Bundle();
            bundle.putString(username,"username");
            fragment.setArguments(bundle);
            intent2 = getIntent().putExtras(bundle);

            ChapterSelect chapterSelect = new ChapterSelect();
            FragmentManager fragmentManager = getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.fragment_container, chapterSelect);
            fragmentTransaction.commit();

        } else if (id == R.id.tests) {
            TestSelect fragment = new TestSelect();
            Bundle bundle = new Bundle();
            bundle.putString(username,"username");
            fragment.setArguments(bundle);
            intent2 = getIntent().putExtras(bundle);

            TestSelect testSelect = new TestSelect();
            FragmentManager fragmentManager = getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.fragment_container, testSelect);
            fragmentTransaction.commit();
        } else if (id == R.id.wall) {
            WallFragment wallFragment = new WallFragment();
            FragmentManager fragmentManager = getSupportFragmentManager();
            FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
            fragmentTransaction.replace(R.id.fragment_container, wallFragment);
            fragmentTransaction.commit();

        } else if (id == R.id.nav_send) {



        }

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;
    }

    @Override
    public void onFragmentInteraction(Uri uri) {

    }
}
