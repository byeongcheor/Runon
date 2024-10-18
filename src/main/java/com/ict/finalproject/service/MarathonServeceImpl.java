package com.ict.finalproject.service;

import com.ict.finalproject.dao.MarathonDAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class MarathonServeceImpl implements MarathonService {

    @Autowired
    private MarathonDAO dao;
//
//    @Override
//    public List<Marathon> getAllMarathons() {
//        log.info("Fetching all marathons from the database.");
//        return dao.findAll();
//    }
}
