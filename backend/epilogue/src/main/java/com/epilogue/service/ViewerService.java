package com.epilogue.service;

import com.epilogue.domain.user.User;
import com.epilogue.domain.viewer.Viewer;
import com.epilogue.domain.will.Will;
import com.epilogue.dto.request.viewer.ViewerRequestDto;
import com.epilogue.dto.request.will.WillRequestDto;
import com.epilogue.repository.user.UserRepository;
import com.epilogue.repository.viewer.ViewerRepository;
import com.epilogue.repository.will.WillRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ViewerService {
    private final ViewerRepository viewerRepository;
    private final WillRepository willRepository;

    public void create(int willSeq, WillRequestDto willRequestDto) {
        List<ViewerRequestDto> viewerList = willRequestDto.getViewerList();

        for (ViewerRequestDto v : viewerList) {
            Viewer viewer = Viewer.builder()
                    .will(willRepository.findById(willSeq).get())
                    .viewerName(v.getViewerName())
                    .viewerEmail(v.getViewerEmail())
                    .viewerPhone(v.getViewerPhone())
                    .build();

            viewerRepository.save(viewer);
        }
    }
}
