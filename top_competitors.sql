SELECT  hackers.hacker_id,
        hackers.name
FROM    submissions
        INNER JOIN challenges USING (challenge_id)
        INNER JOIN difficulty USING (difficulty_level)
        INNER JOIN hackers ON (submissions.hacker_id = hackers.hacker_id)
WHERE   difficulty.score = submissions.score
GROUP BY 1, 2
HAVING COUNT(submissions.challenge_id) > 1
ORDER BY COUNT(submissions.challenge_id) DESC, hackers.hacker_id ASC
;