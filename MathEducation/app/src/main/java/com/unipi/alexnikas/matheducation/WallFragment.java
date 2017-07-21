package com.unipi.alexnikas.matheducation;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.firebase.ui.database.FirebaseRecyclerAdapter;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.squareup.picasso.Picasso;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link WallFragment.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link WallFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class WallFragment extends Fragment{
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private RecyclerView rv;

    private DatabaseReference databaseReference;

    private OnFragmentInteractionListener mListener;

    public WallFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment WallFragment.
     */
    // TODO: Rename and change types and number of parameters
    public static WallFragment newInstance(String param1, String param2) {
        WallFragment fragment = new WallFragment();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_wall,container,false);
        databaseReference = FirebaseDatabase.getInstance().getReference().child("Wall");
        rv = (RecyclerView) view.findViewById(R.id.wall);
        rv.setHasFixedSize(true);
        rv.setLayoutManager(new LinearLayoutManager(getContext()));
        return view;
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }

    @Override
    public void onStart() {
        super.onStart();
        FirebaseRecyclerAdapter<Wall, WallViewHolder> firebaseRecyclerAdapter = new FirebaseRecyclerAdapter<Wall, WallViewHolder> (
            Wall.class,
            R.layout.blog_row,
            WallViewHolder.class,
            databaseReference
        ){
            @Override
            protected void populateViewHolder(WallViewHolder viewHolder, Wall model, int position) {
                viewHolder.setTitle(model.getTitle());
                viewHolder.setDesc(model.getDesc());
                viewHolder.setImage(getContext(),model.getImage());
            }
        };
        rv.setAdapter(firebaseRecyclerAdapter);
    }

    public static class WallViewHolder extends RecyclerView.ViewHolder {

        View view;
        public WallViewHolder(View itemView) {
            super(itemView);
            view = itemView;
        }

        /***
         *
         * @param title
         */
        public void setTitle (String title) {
            TextView post_title = (TextView) view.findViewById(R.id.post_title);
            post_title.setText(title);
        }

        /***
         *
         * @param desc
         */
        public void setDesc (String desc) {
            TextView post_desc = (TextView) view.findViewById(R.id.post_desc);
            post_desc.setText(desc);
        }

        public void setImage (Context ctx, String image) {
            ImageView post_image = (ImageView) view.findViewById(R.id.post_image);
            Picasso.with(ctx).load(image).into(post_image);
        }
    }
}
