package com.plantcare.service;

import com.plantcare.dto.RegisterRequest;
import com.plantcare.dto.RegisterResponse;
import com.plantcare.model.User;
import com.plantcare.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder passwordEncoder;

    public UserService(UserRepository userRepository, BCryptPasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    public RegisterResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new IllegalArgumentException("Email já cadastrado");
        }

        User user = new User(
            request.getEmail(),
            passwordEncoder.encode(request.getPassword()),
            request.getName()
        );

        User saved = userRepository.save(user);

        return new RegisterResponse(saved.getId(), saved.getName(), saved.getEmail());
    }
}
