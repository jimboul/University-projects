package com.unipi.alexnikas.matheducation;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.github.barteksc.pdfviewer.PDFView;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link ChapterView.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link ChapterView#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ChapterView extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;
    private String url;

    private WebView pdfView;
    private StorageReference storRef;

    private OnFragmentInteractionListener mListener;

    public ChapterView() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment ChapterView.
     */
    // TODO: Rename and change types and number of parameters
    public static ChapterView newInstance(String param1, String param2) {
        ChapterView fragment = new ChapterView();
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
        View view = inflater.inflate(R.layout.fragment_chapter_view, container, false);
        pdfView = (WebView) view.findViewById(R.id.pdfView);
        storRef = FirebaseStorage.getInstance().getReference();
        final String chapterSelected = this.getArguments().getString("chapterSelected");
        if (chapterSelected == "Chapter 1") {
            url = "https://www.iusb.edu/tutoring/docs/Basic%20Math%20Review%20Card.pdf";
        }
        else if (chapterSelected == "Chapter 2") {
            url = "https://drive.google.com/open?id=0B_KjtUigjhlVeVd6TWxGR1lheTA";
        }
        else if (chapterSelected == "Chapter 3") {
            url = "https://drive.google.com/open?id=0B_KjtUigjhlVVnZrT3VZdVZuQWM";
        }
        //pathfile = storRef.child("pdf").child(chapterSelected + ".pdf");
        pdfView.getSettings().setJavaScriptEnabled(true);
        pdfView.setScrollBarStyle(WebView.SCROLLBARS_OUTSIDE_OVERLAY);
//        pdfView.getSettings().setPluginState(PluginState.ON);
        pdfView.getSettings().setAllowFileAccess(true);
        //pdfView.loadUrl("https://docs.google.com/viewer?url="+url);//"https://docs.google.com/viewer?url="+
        pdfView.setWebViewClient(new WebViewClient() {
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl("https://docs.google.com/viewer?url="+url);
                return true;
            }});
        //System.out.println("@@@@@@@@@@@@@@"+chapterSelected + "    " + storRef.child("pdf").child(chapterSelected+".pdf"));
        //final StorageReference islandRef = storRef.child("pdf").child(chapterSelected+".pdf");

        //islandRef = storRef.child("images/island.jpg");
        //pdfView.fromAsset("Chapter1");
//        final File localFile;
//        try {
//            localFile = File.createTempFile("chapter", "pdf");
//            islandRef.getFile(localFile).addOnSuccessListener(new OnSuccessListener<FileDownloadTask.TaskSnapshot>() {
//                @Override
//                public void onSuccess(FileDownloadTask.TaskSnapshot taskSnapshot) {
//                    // Local temp file has been create
//                    pdfView.fromFile(localFile);
//                    System.out.println(localFile.getPath());
//                }
//            }).addOnFailureListener(new OnFailureListener() {
//                @Override
//                public void onFailure(@NonNull Exception exception) {
//                    // Handle any errors
//                    System.out.println("Fail!!!!!!!!!!!!!!!!!!");
//                }
//            });
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        final long ONE_MEGABYTE = 1024 * 1024;
//        islandRef.getBytes(ONE_MEGABYTE).addOnSuccessListener(new OnSuccessListener<byte[]>() {
//            @Override
//            public void onSuccess(byte[] bytes) {
//                // Data for "images/island.jpg" is returns, use this as needed
//                System.out.println("@@@@@@@@@@@@"+bytes);
//                pdfView.fromBytes(bytes);
//            }
//        }).addOnFailureListener(new OnFailureListener() {
//            @Override
//            public void onFailure(@NonNull Exception exception) {
//                // Handle any errors
//            }
//        });

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
}
